import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {

  var profileImPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  ///textField

  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  changeImage (context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      if(img == null) return;
      profileImPath.value = img.path;
    } on PlatformException  catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }


  ///upload profile image
  uploadProfileImage()async {

    var fileName = basename(profileImPath.value);
    var destination = 'images/${currentUser!.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = fireStore.collection('users').doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imgUrl,
    },SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({email, password, newPassword})async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });

  }


}