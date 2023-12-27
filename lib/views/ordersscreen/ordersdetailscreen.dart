import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/views/ordersscreen/components/order_place_detail.dart';
import 'package:mycart/views/ordersscreen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class Orders_details extends StatelessWidget {
  final dynamic data;



  const Orders_details({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: "Order Detail".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          orderStatus(
                              color: redColor,
                              icon: Icons.done,
                              title: "Order Placed",
                              showdone: data[index]['order_placed']
                          ),
                          orderStatus(
                              color:Vx.blue500,
                              icon: Icons.thumb_up_alt,
                              title: "Confirmed",
                              showdone: data[index]['order_confirmed']
                          ),
                          orderStatus(
                              color: Vx.yellow500,
                              icon: Icons.local_shipping,
                              title: "Delivery",
                              showdone: data[index]['order_on_delivery']
                          ),
                          orderStatus(
                              color: Vx.green500,
                              icon: Icons.done_all,
                              title: "Delivered",
                              showdone: data[index]['order_delivered']
                          ),


                          Divider(),
                          10.heightBox,

                          Column(
                            children: [
                              OrderPlacedDetail(
                                  d1: "${data[index]['order_no']}",
                                  d2: "${data[index]['shipping_method']}",
                                  title1: "Order Code",
                                  title2: "Shipping Method"
                              ),
                              OrderPlacedDetail(
                                 d1: intl.DateFormat().add_yMd().format((data[index]['order_date'].toDate())),
                                  d2: "${data[index]['payment_method']}",
                                  title1: "Order Date",
                                  title2: "Payment Method"
                              ),
                              OrderPlacedDetail(
                                  d1: "Unpaid",
                                  d2: "Order Placed",
                                  title1: "Payment Status",
                                  title2: "Delivery Status"
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        "Shipping Address".text.fontFamily(semibold).make(),
                                        "${data[index]['order_by_name']}".text.make(),
                                        "${data[index]['order_by_email']}".text.make(),
                                        "${data[index]['order_by_address']}".text.make(),
                                        "${data[index]['order_by_city']}".text.make(),
                                        "${data[index]['order_by_state']}".text.make(),
                                        "${data[index]['order_by_phone']}".text.make(),
                                        "${data[index]['order_by_postalcode']}".text.make(),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 130,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          "Total Amount".text.fontFamily(semibold).make(),
                                          "${data[index]['Total Amount']}".text.color(Colors.red).fontFamily(bold).make(),

                                        ],

                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ).box.outerShadowMd.white.make(),

                          Divider(),
                          10.heightBox,

                          "Order Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),

                          10.heightBox,

                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children:  List.generate(1, (index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OrderPlacedDetail(
                                      title1: "${data[index]['orders'][index]['title']}",
                                      title2: "${data[index]['orders'][index]['tprice']}",
                                      d1: "${data[index]['orders'][index]['qty']}",
                                      d2: "Refundable"
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      // color: Color(data['orders'][index]['color']),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );

                            }).toList(),
                          ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
                          20.heightBox,



                        ],
                      ),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
