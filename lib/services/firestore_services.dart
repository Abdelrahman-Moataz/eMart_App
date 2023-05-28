import 'package:emart/consts/consts.dart';



class FireStoreServices {


  ///get users data
  static getUser (uid){
    return fireStore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }

  ///get products according to category

    static getProducts(category){
    return fireStore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
    }

    static getSubCategoryProducts(title){
      return fireStore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();
    }

    /// get cart
    static getCart(uid){
    return fireStore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
    }

    ///delete document

    static deleteDocument (docId){
    return fireStore.collection(cartCollection).doc(docId).delete();
    }

    /// get all chat messages
    static getChatMessages(docId){
    return fireStore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
    }
    
    
    static getAllOrders(){
    return fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
    }


    static getWishlists(){
    return fireStore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
    }


    static getAllMessages(){
      return fireStore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
    }

    static getCounts() async {
    var res = Future.wait([

      fireStore.collection(cartCollection).where('added_by', isEqualTo:  currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),

      fireStore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),

      fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),

    ]);
    return res;
    }

    static allProducts(){
    return fireStore.collection(productsCollection).snapshots();

    }

    static getFeaturedProducts(){
    return fireStore.collection(productsCollection).where("is_featured", isEqualTo: true ).get();
    }
    
    static searchProducts(title){
    return fireStore.collection(productsCollection).get();
    }






}