import 'package:emart/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

import '../../../controllers/chat_controller.dart';

Widget senderBubble(DocumentSnapshot data){

  var controller = Get.put(ChatsController());

  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = intl.DateFormat("h:mm a").format(t);

  return Directionality(
    textDirection:  data['uid'] == currentUser!.uid ? TextDirection.rtl: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 5),
      decoration:  BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor: darkFontGrey,
        borderRadius:
        data['uid'] == currentUser!.uid ?

        const  BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ) :
        const  BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )




      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //todo check this one after making the seller app
          controller.senderName.text.color(whiteColor.withOpacity(0.5)).make(),

          "${data['msg']}".text.white.size(16).make(),
          5.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}