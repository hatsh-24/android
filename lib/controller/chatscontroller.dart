import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';

import 'home_controller.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getChatId();
    super.onInit();
  }
  var isLoading = false.obs;

  var chats = firestore.collection(chatscollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.put(Homecontroller()).username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  getChatId() async {

    isLoading (true);

    await chats.where('users',isEqualTo: {
      friendId:null,
      currentId:null
    }).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }
      else{
        chats.add({

          "created_on":null,
          "last_msg":'',
          "users":{friendId:null,currentId:null},
          "toId":"",
          "fromId":currentId,
          "friend_name":friendName,
          "sender_name":senderName

        }).then((value){
          chatDocId = value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg)async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        "created_on":FieldValue.serverTimestamp(),
        "last_msg":msg,
        "toId":friendId,
        "fromId":currentId
      });

      chats.doc(chatDocId).collection(messagecollection).doc().set({
        "created_on":FieldValue.serverTimestamp(),
        "msg":msg,
        "uid":currentId
      });

    }
  }

}