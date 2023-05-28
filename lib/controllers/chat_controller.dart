


import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';

class ChatsController extends GetxController{


  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = fireStore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading = false.obs;

  getChatId()async {

    isLoading(true);

    await chats.where('users', isEqualTo: {
    friendId: null,
    currentId:null
    }
    ).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on':null,
          'last_msg' : '' ,
          'users': {friendId: null, currentId: null},
          'toId': '',
          'fromId': '',
          'friend_name': friendName,
          'sender_name': senderName,
        }).then((value) {
          chatDocId = value.id;
        });
      }
    });

    isLoading(false);

  }



  sendMsg(String msg)async {
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg':msg,
        'toId': friendId,
        'fromId': currentId,
        'sender_name': senderName,
      });
      
      
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg':msg,
        'uid': currentId,

      });
      
    }
    }


}