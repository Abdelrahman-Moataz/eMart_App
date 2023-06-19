import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/chat_screen/messaging_screen.dart';
import 'package:emart/views/order_screen/order_screen.dart';
import 'package:emart/views/profile_screen/edite_profile_name.dart';
import 'package:emart/views/profile_screen/edited_profile_image.dart';
import 'package:emart/views/profile_screen/edited_profile_password.dart';
import 'package:emart/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/loading_indecator.dart';
import 'package:emart/widgets_common/our_button.dart';

import 'components/details_cart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: StreamBuilder(
        stream: FireStoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  ///user details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                emptyProfile,
                                width: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              15.heightBox,
                              "${data['email']}".text.white.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                            color: whiteColor,
                          )),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signOutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make(),
                        ),
                      ],
                    ),
                  ),

                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ///edite profile button
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: const Icon(
                      //       Icons.edit,
                      //       color: whiteColor,
                      //     ).onTap(() {
                      //       controller.nameController.text = data['name'];
                      //
                      //       Get.to(() => EditProfileImage(
                      //             data: data,
                      //           ));
                      //     }),
                      //   ),
                      // ),
                      ourButton(
                          onPress: () {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileImage(
                                  data: data,
                                ));
                          },
                          color: Colors.transparent,
                          textColor: whiteColor,
                          title: "Change picture"),

                      ///edite profile Name

                      ourButton(
                          onPress: () {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileName(
                                  data: data,
                                ));
                          },
                          color: Colors.transparent,
                          textColor: whiteColor,
                          title: "Change Name"),

                      ///edited profile password

                      ourButton(
                          onPress: () {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfilePassword(
                                  data: data,
                                ));
                          },
                          color: Colors.transparent,
                          textColor: whiteColor,
                          title: "Change Password"),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: const Icon(
                      //       Icons.edit,
                      //       color: whiteColor,
                      //     ).onTap(() {
                      //       controller.nameController.text = data['name'];
                      //
                      //       Get.to(() => EditProfileImage(
                      //             data: data,
                      //           ));
                      //     }),
                      //   ),
                      // ),
                    ],
                  ),
                  20.heightBox,

                  FutureBuilder(
                    future: FireStoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "in your cart",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "in your wishlist",
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: countData[2].toString(),
                                title: "your orders",
                                width: context.screenWidth / 3.4),
                          ],
                        );
                      }
                    },
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(count: data['cart_count'], title: "in your cart", width: context.screenWidth /3.4),
                  //     detailsCard(count: data['wishlist_count'], title: "in your wishlist", width: context.screenWidth /3.4),
                  //     detailsCard(count: data['order_count'], title: "your orders", width: context.screenWidth /3.4),
                  //   ],
                  // ),

                  ///buttons sections

                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => const WishListScreen());
                              break;
                            case 2:
                              Get.to(() => const MessagesScreen());
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonsList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonsList.length,
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ),
            );
          }
        },
      ),
    )));
  }
}
