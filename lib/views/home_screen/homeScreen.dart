import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/home_screen/search_screen.dart';
import 'package:emart/widgets_common/home_buttons.dart';
import 'package:emart/widgets_common/loading_indecator.dart';

import '../../controllers/home_controller.dart';
import '../category_screen/items_details.dart';
import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    var controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnyThing,
                    hintStyle: const TextStyle(
                      color: textfieldGrey,
                    )),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ///swiper brands

                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 150,
                    //     enlargeCenterPage: true,
                    //     itemCount: sliderList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         sliderList[index],
                    //         fit: BoxFit.fitWidth,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashSale,
                        ),
                      ),
                    ),

                    /// sec swiper

                    10.heightBox,

                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 150,
                    //     enlargeCenterPage: true,
                    //     itemCount: secondSlidersList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         secondSlidersList[index],
                    //         fit: BoxFit.fitWidth,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),

                    10.heightBox,

                    /// second buttons

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brand
                                  : topSellers,
                        ),
                      ),
                    ),

                    ///featured categories
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuresCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    20.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImages1[index],
                                        title: featuredTitles1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImages2[index],
                                        title: featuredTitles2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),

                    ///featured product
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FireStoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No featured products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;

                                    return Row(
                                      children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featuredData[index]['p_imgs'][0],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "${featuredData[index]['p_name']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${featuredData[index]['p_price']}"
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
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .roundedSM
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemsDetails(
                                                title:
                                                    "${featuredData[index]['p_name']}",
                                                data: featuredData[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),

                    /// Third swiper
                    20.heightBox,

                    // VxSwiper.builder(
                    //     aspectRatio: 16 / 9,
                    //     autoPlay: true,
                    //     height: 150,
                    //     enlargeCenterPage: true,
                    //     itemCount: sliderList.length,
                    //     itemBuilder: (context, index) {
                    //       return Image.asset(
                    //         sliderList[index],
                    //         fit: BoxFit.fitWidth,
                    //       )
                    //           .box
                    //           .rounded
                    //           .clip(Clip.antiAlias)
                    //           .margin(const EdgeInsets.symmetric(horizontal: 8))
                    //           .make();
                    //     }),

                    /// all products section

                    20.heightBox,
                    StreamBuilder(
                        stream: FireStoreServices.allProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var allProductsData = snapshot.data!.docs;

                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProductsData.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allProductsData[index]['p_imgs'][0],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allProductsData[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allProductsData[index]['p_price']}"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemsDetails(
                                        title:
                                            "${allProductsData[index]['p_name']}",
                                        data: allProductsData[index],
                                      ));
                                });
                              },
                            );
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
