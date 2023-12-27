import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/chatscontroller.dart';
import 'package:mycart/controller/services/firestore_service.dart';

import 'components/sender_bubble.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());


    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),

      ),

      body: Padding(
          padding: const EdgeInsets.all(0.8),
          child: Column(

            children: [
              Obx(() =>
              controller.isLoading.value ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
              ) :
              Expanded(child: StreamBuilder(
                stream: FirestoreServices.getChatMessages(
                    controller.chatDocId.toString()),

                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Colors.redAccent),),
                    );
                  }
                  else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "Send Message...".text.color(darkFontGrey).make(),
                    );
                  }
                  else {
                    return ListView(

                      children: snapshot.data!.docs.mapIndexed((currentValue, index){

                        var data = snapshot.data!.docs[index];

                        return Align(
                            alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight: Alignment.centerLeft,
                            child: senderBubble(data));
                      }).toList(),
                    );
                  }
                },


              )),
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: controller.msgController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)
                        ),
                        hintText: "Type Message..."
                    ),
                  )),
                  IconButton(onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  }, icon: Icon(Icons.send, color: Colors.redAccent,))
                ],
              ).box.height(80).margin(EdgeInsets.only(bottom: 8)).padding(
                  EdgeInsets.all(12)).make()
            ],
          )),

    );
  }

}
