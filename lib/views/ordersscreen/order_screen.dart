import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycart/views/ordersscreen/ordersdetailscreen.dart';

import '../../consts/consts.dart';

class Order_Screen extends StatelessWidget {
  const Order_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.redAccent),
              ),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return "Nothing Here!Order Something".text.color(darkFontGrey).makeCentered();
          }
          else{

            var data = snapshot.data!.docs;


            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: data[index]['order_no'].toString().text.color(Colors.red).fontFamily(semibold).make(),
                    subtitle: data[index]['Total Amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(onPressed: (){Get.to(()=>Orders_details());},icon: Icon(Icons.arrow_forward_ios_rounded,color: darkFontGrey),),
                    leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
