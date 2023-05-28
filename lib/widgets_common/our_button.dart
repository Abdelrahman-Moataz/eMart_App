import 'package:emart/consts/consts.dart';

Widget ourButton({required Function() onPress, required Color color, required Color textColor,required String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title?.text.color(textColor).fontFamily(bold).make(),
  );
}
