import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Cart_Screen/shipping_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/controller/services/firestore_service.dart';
import 'package:mycart/widgets/button.dart';
import 'package:mycart/consts/consts.dart';
import '../controller/productcontroller.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());


    return Scaffold(
        backgroundColor: Vx.gray300,
        bottomNavigationBar: SizedBox(
          width: context.screenWidth-60,
          height: 60,
          child: mybutton(
              bclor: color(Vx.red50),
              onPress: () {
                if(controller.totalP.value==0){
                  VxToast.show(context, msg: "msg");
                  
                }else{
                Get.to(()=> ShippingDetail());}
              },
              title: "Proceed To Ship",
              tcolr: whiteColor),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "My Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),

        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot>snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
              );
            }
            else if (snapshot.data!.docs.isEmpty) {
              return Center(

                child: "Cart is Empty".text.color(darkFontGrey).make(),

              );

           }
            else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productsnapshot = data;


              return Padding(
                padding: EdgeInsets.all(0.8),
                child: Column(
                  children: [
                    Expanded(

                        child: ListView.builder(
                           itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                    "${data[index]['img']}",
                                  width: 100,
                                    height: 120,
                                    fit: BoxFit.cover,
                                ),
                                title: "${data[index]['title']} (x ${data[index]['qty']})".toString().text.make(),
                                subtitle: "${data[index]['tprice']}".numCurrency.text.color(Colors.red).fontFamily(semibold).make(),
                                trailing: const Icon(Icons.delete,color: Colors.red,).onTap(() {
                                  FirestoreServices.delete(data[index].id);
                                }),


                              );
                            }
                        )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price".text.fontFamily(semibold).color(
                            darkFontGrey).make(),
                        Obx(
            ()=> "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(
                              Colors.redAccent).make(),
                        ),
                      ],
                    ).box
                        .padding(EdgeInsets.all(12))
                        .color(Colors.yellowAccent)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    10.heightBox,

                   // SizedBox(
                     //   width: context.screenWidth - 60,
                       // child: mybutton(
                         //   bclor: color(Vx.red50),
                           // onPress: () {},
                            //title: "Proceed To Ship",
                            //tcolr: whiteColor
                        //))

                  ],
                ),
              );


          }
          },
        )

    );
  }
}
