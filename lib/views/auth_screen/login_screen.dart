import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:emart/widgets_common/applogo_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';

import '../../widgets_common/bg_widget.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appName".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        hint: emailHint,
                        title: email,
                        isPass: false,
                        controller: controller.emailController),
                    customTextField(
                        hint: passwordHint,
                        title: password,
                        isPass: true,
                        controller: controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPassword.text.make(),
                      ),
                    ),
                    5.heightBox,

                    //ourButton().box.width(context.screenWidth - 50).make(),

                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                                onPress: () async {
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedIn);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isLoading(false);
                                    }
                                  });
                                },
                                color: redColor,
                                textColor: whiteColor,
                                title: "Login")
                            .box
                            .width(context.screenWidth - 50)
                            .make(),

                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(
                            onPress: () {
                              Get.to(() => const SignupScreen());
                            },
                            color: lightGolden,
                            textColor: redColor,
                            title: "Signup")
                        .box
                        .width(context.screenWidth - 50)
                        .make(),

                    10.heightBox,
                    // loginWith.text.color(fontGrey).make(),
                    // 5.heightBox,
                    // Row(mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(3, (index) => Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: CircleAvatar(
                    //       radius: 25,backgroundColor: lightGrey,
                    //       child: Image.asset(socialIconList[index],width: 30,),
                    //     ),
                    //   ),
                    //   ),
                    // )
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
