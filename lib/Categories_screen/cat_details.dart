import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Categories_screen/item_details.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/consts/strings.dart';
import 'package:mycart/controller/productcontroller.dart';
import 'package:mycart/controller/services/firestore_service.dart';
import 'package:mycart/widgets/bg.dart';

class Cat_details extends StatelessWidget {
  final String? title;

  const Cat_details({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return bg(
      Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData)
              {
                return Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
                );
              }
            else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Products".text.color(darkFontGrey).make(),
              );
            }
            else{

              var data = snapshot.data!.docs;

              return Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .white
                                .rounded
                                .size(120, 50)
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .make()),
                      ),
                    ),

                    20.heightBox,
                    //item container
                    Expanded(
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_image'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                data[index]['p_name'].toString()
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                data[index]['p_price'].toString().numCurrency
                                    .text
                                    .fontFamily(bold)
                                    .color(Colors.red)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .padding(EdgeInsets.all(12))
                                .make().onTap(() {
                                  controller.checkifFav(data[index]);
                              Get.to(Item_details(title: data[index]['p_name'].toString(),data: data[index],));
                            });
                          }),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
