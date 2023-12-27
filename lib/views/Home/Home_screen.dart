// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Categories_screen/item_details.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/controller/home_controller.dart';
import 'package:mycart/controller/productcontroller.dart';
import 'package:mycart/views/Home/components/features_btn.dart';
import 'package:mycart/views/Home/search.dart';
import 'package:mycart/widgets/home_button.dart';

class Home_screen extends StatelessWidget {

  const Home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Homecontroller>();
    Get.put(ProductController());
    Get.lazyPut(() => ProductController());
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            //search
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if(controller.searchcontroller.text.isNotEmptyAndNotNull){
                      Get.to(()=>Searchscreen(title: controller.searchcontroller.text,));
                    }

                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchp,
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ).box.outerShadowSm.make(),
            ),

          //  5.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [




                    //feature categories






                    //feature_product
                    20.heightBox,
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featureproduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getfeaturedproduct(),
                               builder: (context,AsyncSnapshot<QuerySnapshot>  snapshot){
                                 if (!snapshot.hasData) {
                                   return Center(
                                     child: CircularProgressIndicator(
                                       valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                                     ),
                                   );
                                 }
                                 else if(snapshot.data!.docs.isEmpty){
                                   return "No Fetures Products".text.white.makeCentered();
                                 }
                                else {

                                  var featuredata = snapshot.data!.docs;

                                   return Row(
                                     children: List.generate(
                                       featuredata.length, (index) =>
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment
                                               .start,

                                           children: [
                                             Image.network(featuredata[index]['p_image'][0], width: 150,height: 120,
                                               fit: BoxFit.cover,),
                                             10.heightBox,
                                             "${featuredata[index]['p_name']}".text
                                                 .fontFamily(semibold).color(
                                                 darkFontGrey).make(),
                                             10.heightBox,
                                             "${featuredata[index]['p_price']}".text.fontFamily(bold)
                                                 .color(Colors.red).size(16)
                                                 .make()
                                           ],
                                         ).box.white.roundedSM.margin(
                                             EdgeInsets.symmetric(
                                                 horizontal: 4)).padding(
                                             EdgeInsets.all(8)).make().onTap(() {
                                           Get.to(()=>Item_details(title:"${featuredata[index]['p_name']}",data: featuredata[index],));

                                         }),),
                                   );
                                 }
                               },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //swiper3
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 100,
                        enlargeCenterPage: true,
                        itemCount: brandslider2.length,
                        itemBuilder: (context, index) {
                          return Image.asset(brandslider2[index],
                              fit: BoxFit.fitWidth)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make();
                        }),
                    
                    //all Products section
                    20.heightBox,
        StreamBuilder(
        stream: FirestoreServices.allProducts(),
    builder:
    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.redAccent),
          ),
        );
      }
      else{
        var allProductsdata = snapshot.data!.docs;

       return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allProductsdata.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300),
            itemBuilder: (context,index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(allProductsdata[index]['p_image'][0],height: 200,width: 200,fit: BoxFit.cover,),
                  Spacer(),
                  "${allProductsdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                  10.heightBox,
                  "${allProductsdata[index]['p_price']}".text.fontFamily(bold).color(Colors.red).size(16).make()
                ],
              ).box.white.roundedSM.margin(EdgeInsets.symmetric(horizontal: 4)).padding(EdgeInsets.all(12)).make().onTap(() {
                Get.to(()=>Item_details(title:"${allProductsdata[index]['p_name']}",data: allProductsdata[index],),);
              });

            });
      }
    })


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
