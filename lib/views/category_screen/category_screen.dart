import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../widgets_common/bg_widget.dart';
import 'categories_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(ProductController());

    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 8, mainAxisExtent: 200),
            itemBuilder: (context, index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(categoriesImages[index],height: 130,width: 200,fit: BoxFit.cover,),
                  10.heightBox,
                  categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                ],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowLg.make().onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(()=> CategoryDetails(title: categoriesList[index]));
              });
            },

          ),
        ),
      )
    );
  }
}
