import 'package:emart/consts/consts.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                onPress: () {
                  SystemNavigator.pop();
                },
                color: redColor,
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                onPress: () {
                  Navigator.pop(context);
                },
                color: redColor,
                textColor: whiteColor,
                title: "No")
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
