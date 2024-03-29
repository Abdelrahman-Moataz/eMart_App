import 'package:emart/controllers/product_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emart/consts/consts.dart';
import '../../widgets_common/loading_indecator.dart';
import 'items_details.dart';



class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }


  switchCategory(title){
    if(controller.subCat.contains(title)){
      productMethod =  FireStoreServices.getSubCategoryProducts(title);
    }else{
      productMethod =  FireStoreServices.getProducts(title);
    }
  }



  var controller = Get.find<ProductController>();
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {



    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subCat.length,
                        (index) => "${controller.subCat[index]}"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() {
                          switchCategory('${controller.subCat[index]}');
                          setState(() {

                          });
                        }),
                ),
              ),
            ),
            20.heightBox,


            StreamBuilder(
                stream: productMethod,

              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                  if(!snapshot.hasData){
                    return Expanded(
                      child: loadingIndicator(),
                    );
                  }else if(snapshot.data!.docs.isEmpty){
                    return Expanded(
                      child: "No products found!".text.color(darkFontGrey).makeCentered(),
                    );
                  }else{

                    var data = snapshot.data!.docs;

                    return
                          ///items container

                          Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 280,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 150,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .outerShadowSm
                                    .padding(const EdgeInsets.all(12))
                                    .make().onTap(() {
                                      controller.checkIfFav(data[index]);
                                  Get.to(()=> ItemsDetails(title: "${data[index]['p_name']}",data: data[index],));
                                });
                              },
                            ),
                          );

                  }
              },
            ),
          ],
        )

      ),
    );
  }
}

