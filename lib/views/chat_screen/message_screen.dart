import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycart/views/chat_screen/chat_screen.dart';

import '../../consts/consts.dart';

class Messages_Screen extends StatelessWidget {
  const Messages_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: "My Chats".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.redAccent),
              ),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No messages yet!".text.color(darkFontGrey).makeCentered();
          }
          else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index){
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.person_rounded,color: Colors.white,),
                            ),
                            title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),

                          ),
                        ).onTap(() {
                          Get.to(()=>chatScreen(),arguments:[
                            data[index]['friend_name'],
                            data[index]['toId']
                          ], );
                        });
                      }
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
