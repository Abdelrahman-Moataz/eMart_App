import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/our_button.dart';

class EditProfileImage extends StatelessWidget {
  final dynamic data;

  const EditProfileImage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.passController.text = data['password'];

    return bgWidget(
      Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// if data image url and controller path is empty

                data['imageUrl'] == '' && controller.profileImPath.isEmpty
                    ? Image.asset(
                        emptyProfile,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

                    ///if data is not empty but controller path in empty

                    : data['imageUrl'] != '' && controller.profileImPath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()

                        /// else if controller path is not empty but data image url is

                        : Image.file(
                            File(controller.profileImPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,

                SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(
                      onPress: () {
                        controller.changeImage(context);
                      },
                      color: golden,
                      textColor: whiteColor,
                      title: "Change"),
                ),

                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                            onPress: () async {
                              controller.isLoading(true);

                              ///if image is not selected
                              if (controller.profileImPath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                                await controller.updateProfileImage(
                                  imgUrl: controller.profileImageLink,
                                );

                                VxToast.show(context, msg: "Updated");
                                controller.isLoading(false);
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                                VxToast.show(context, msg: "Wrong one");
                                controller.isLoading(false);
                              }

                              /// if all password matched data base
                              // if (data['password'] ==
                              //     controller.oldPassController.text) {
                              //   await controller.changeAuthPassword(
                              //       email: data['email'],
                              //       password: controller.oldPassController.text,
                              //       newPassword:
                              //       controller.newPassController.text);
                              //   await controller.updateProfile(
                              //       imgUrl: controller.profileImageLink,
                              //       name: controller.nameController.text,
                              //       password:
                              //       controller.newPassController.text);
                              //   VxToast.show(context, msg: "Updated");
                              //   Get.to(const ProfileScreen());
                              //  } else {
                              //   VxToast.show(context, msg: "type password to proccess");
                              //   controller.isLoading(false);
                            },
                            color: redColor,
                            textColor: whiteColor,
                            title: "save")),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
