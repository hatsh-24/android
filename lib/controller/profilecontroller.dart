import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';
import 'package:path/path.dart';

class Profilecontroller extends GetxController {
  late QueryDocumentSnapshot snspshotdata;
  var profileImgpath = ''.obs;
  var profileimagelink = '';

  var isloadingtf = false.obs;

  var namecontroller = TextEditingController();
  var oldpasscontroller = TextEditingController();
  var newpasscontroller = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {return;}else{
      profileImgpath.value = img.path;}
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload image

  uploadProfileImage() async {
    var filename = basename(profileImgpath.value);
    var destination = "images/${currentUser!.email}/filename";

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgpath.value));
    profileimagelink = await ref.getDownloadURL();
  }

  //upadate profile

  updatweprofile({name,pass,imgurl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
   await store.set({
      "name": name,
      "pass": pass,
      "imgurl": imgurl,

    }, SetOptions(merge: true));
   isloadingtf(false);
  }

  changeAuthPassword({email,password,newpassword})async{
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newpassword);
    }).catchError((error){});
  }
}