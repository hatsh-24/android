import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycart/consts/consts.dart';

class Authcontroller extends GetxController {

  var isloading = false.obs;
  //text controllers
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passcontroller.text);
    } on FirebaseException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//store userdata
  storeUserData({name,pass,email}) async {
    DocumentReference store = await firestore.collection(usersCollection).doc();

    store.set({
      'name': name,
      'pass': pass,
      'email': email,
      'imgurl': "",
      'cartcount':'00',
      'wishlistcount':'00',
      'ordercount':'00',
      'uid': email

    });
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}

