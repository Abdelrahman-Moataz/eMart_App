import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';

class EditProfileName extends StatelessWidget {
  final dynamic data;

  const EditProfileName({Key? key, this.data}) : super(key: key);

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
                //const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
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

                              // if all password matched data base
                              if (controller.nameController.value != null) {
                                await controller.updateProfileName(
                                  name: controller.nameController.text,
                                );
                                VxToast.show(context, msg: "Updated");
                                //Get.to(const ProfileScreen());
                              } else {
                                VxToast.show(context,
                                    msg: "Something went wrong");
                                controller.isLoading(false);
                              }
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
