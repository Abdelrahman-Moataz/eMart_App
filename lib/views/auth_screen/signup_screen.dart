import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Join the $appName".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,

              Obx(
                  ()=> Column(
                  children: [
                    customTextField(hint: nameHint, title: name,controller: nameController,isPass: false),
                    customTextField(hint: emailHint, title: email, controller: emailController, isPass: false),
                    customTextField(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                    customTextField(hint: passwordHint, title: retypePassword, controller: passwordRetypeController, isPass: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPassword.text.make(),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: redColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue;
                                });
                              },
                            ),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey),
                                  ),
                                  TextSpan(
                                    text: termsAndCon,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),

                        5.heightBox,
                        //ourButton().box.width(context.screenWidth - 50).make(),


                       controller.isLoading.value ?
                       const CircularProgressIndicator(
                         valueColor:  AlwaysStoppedAnimation(redColor),
                       ) :

                           ourButton(onPress: ()async{
                             if(isCheck != false){
                               controller.isLoading(true);
                               try{
                                 await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text)
                                     .then((value)  {
                                   return controller.storeUserData(
                                       email: emailController.text,
                                       password: passwordController.text,
                                       name: nameController.text
                                   );
                                 }).then((value) {
                                   VxToast.show(context, msg: loggedIn);
                                   Get.offAll(()=>const Home());
                                 });
                               }catch (e){
                                 auth.signOut();
                                 VxToast.show(context, msg: e.toString());
                                 controller.isLoading(false);
                               }
                             }

                           }, color: isCheck == true ? redColor : lightGrey, textColor: whiteColor, title: "Sign up").box
                               .width(context.screenWidth - 50)
                               .make(),




                        10.heightBox,

                        //wrapping into gesture detector of velocity x

                        RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: alreadyHaveAnAccount,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: login,
                                style: TextStyle(
                                  fontFamily: bold,
                                  color: redColor,
                                )),
                          ]),
                        ).onTap(() {
                           Get.to(()=>const LoginScreen());
                        }),
                      ],
                    ),
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
