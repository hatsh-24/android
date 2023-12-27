import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/consts/strings.dart';
import 'package:mycart/controller/productcontroller.dart';
import 'package:mycart/views/chat_screen/chat_screen.dart';
import 'package:mycart/widgets/bg.dart';
import 'package:mycart/widgets/button.dart';

class Item_details extends StatelessWidget {
  final String? title;
  final dynamic data;

  const Item_details({Key? key, required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    print(Colors.purple.value);
    return WillPopScope(
      onWillPop:()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading:IconButton(onPressed: (){
            controller.resetValues();
            Get.back();
          },icon:Icon(Icons.arrow_back_ios) ,),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
              ),
            ),
            Obx(
              ()=> IconButton(
                onPressed: () {
                  if(controller.isFav.value){
                    controller.removefromWishlist(data.id,context);
                   // controller.isFav(false);
                  }
                  else{
                    controller.addtoWishlist(data.id,context);
                   // controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite_sharp,
                  color: controller.isFav.value ? Colors.red : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_image'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_image'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),
                    10.heightBox,
                    //title and details
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    //rating
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 20,
                      count: 5,
                      maxRating: 5,
                      isSelectable: false,
                      stepInt: false,
                    ),

                    10.heightBox,
                    data['p_price'].toString().numCurrency
                        .text
                        .color(Colors.orange)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            data['p_seller'].toString()
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ).onTap(() {
                            Get.to(()=>chatScreen(),
                            arguments:[
                              data['p_seller'],
                              data['vendore_id']
                            ],
                            );
                          }),
                        ),
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    //color section
                    20.heightBox,
                    Obx(
                      ()=>Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                            .margin(EdgeInsets.symmetric(horizontal: 6))
                                            .make().onTap(() {
                                              controller.changecolor(index);
                                        }),

                                           Visibility(
                                            visible: index == controller.colorindex.value,
                                            child: const Icon(Icons.done,color:Colors.white),),
                                      ],
                                    )),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //quantity

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                    ()=> Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {controller.decreasQuantity();
                                        controller.calculatetotalprice(int.parse(data['p_price']));
                                          }, icon: Icon(Icons.remove)),
                                    controller.Quantity.value
                                        .text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {controller.increasQuantity(
                                          int.parse(data['p_quantity']));
                                          controller.calculatetotalprice(int.parse(data['p_price']));
                                          }, icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity'].toString()})Available".text.color(textfieldGrey).make()
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalprice.value}".numCurrency.text.color(Colors.orange).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                        ],
                      ).box.white.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    data['p_desc'].toString().text.color(darkFontGrey).make(),

                   //buttons
                    10.heightBox,
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                              itembtn.length,
                              (index) => ListTile(
                        title: (itembtn[index]).text.fontFamily(semibold).color(darkFontGrey).make(),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )),
                    ),
                    //you also like
                    20.heightBox,
                    productalsoyou.text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                    //get from hom screen (copy from home screen)
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                            10.heightBox,
                            "Laptop 4Gb or 64Gb".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "\$500".text.fontFamily(bold).color(Colors.red).size(16).make()
                          ],
                        ).box.white.roundedSM.margin(EdgeInsets.symmetric(horizontal: 4)).padding(EdgeInsets.all(8)).make(),),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: mybutton(
                 // bclor: color(Colors.lightBlue),
                  onPress: () {

                    if(controller.Quantity.value>0){
                      controller.addTocart(
                          color: data['p_colors'][controller.colorindex.value],
                          context: context,
                          vendoreID: data['vendore_id'],
                          img: data['p_image'][0],
                          qty: controller.Quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: controller.totalprice.value
                      );
                      VxToast.show(context, msg: "Added To Your Cart.");
                    }else{
                      VxToast.show(context, msg: "Minimum 1 Product is Required");
                    }



                  },
                  tcolr: whiteColor,
                  title: "Add To Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
