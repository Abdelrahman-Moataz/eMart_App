

import 'package:emart/consts/consts.dart';
import 'package:emart/models/categories_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var subCat = [];

  var isFav = false.obs;


  getSubCategories(title)async {
    subCat.clear();
     var data = await rootBundle.loadString("lib/services/category_model.json");
     var decoded = categoryModelFromJson(data);
     var s = decoded.categories.where((element) => element.name == title).toList();

     for(var e in s[0].subcategory){
       subCat.add(e);
     }
  }


  changeColorIndex(index){
    colorIndex.value = index;
  }


  increaseQuantity(totalQuantity){
    if(quantity.value < totalQuantity){
      quantity.value++;
    }
  }

  decreaseQuantity(){
    if(quantity.value > 0){
      quantity.value--;
    }
  }


  calculatingTotalPrice(price){
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellerName, color, qty, tPrice, context, vendorId})async{
    await fireStore.collection(cartCollection).doc().set({

      'title': title,
      'img':img,
      'sellerName': sellerName,
      'color': color,
      'qty': qty,
      'tPrice': tPrice,
      'vendor_id': vendorId,
      'added_by': currentUser!.uid,
      'is_featured': false,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }
  
  addToWishList(docId,context)async {
    await fireStore.collection(productsCollection).doc(docId).set({

      'p_wishlist': FieldValue.arrayUnion([
        currentUser!.uid
      ])


    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishList");
  }

  removeFromWishList(docId, context)async {
    await fireStore.collection(productsCollection).doc(docId).set({

      'p_wishlist': FieldValue.arrayRemove([
        currentUser!.uid
      ])


    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishList");
  }


  checkIfFav(data)async {
    if(data['p_wishlist'].cotains(currentUser!.uid)){
      isFav(true);
    }
    else{
      isFav(false);
    }
  }



}