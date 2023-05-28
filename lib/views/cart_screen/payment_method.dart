import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:emart/widgets_common/loading_indecator.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                   await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethodsStrings[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                   await controller.clearCart();
                   VxToast.show(context, msg: "Order placed successfully ");
                   Get.offAll(const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place my order",
                ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethodsImg.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            colorBlendMode: controller.paymentIndex.value == index
                                ? BlendMode.darken
                                : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.4)
                                : Colors.transparent,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: paymentMethodsStrings[index]
                                .text
                                .white
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
