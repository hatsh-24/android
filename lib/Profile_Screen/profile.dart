import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycart/Profile_Screen/components/detailcard.dart';
import 'package:mycart/Profile_Screen/edit_profile.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/images.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/controller/authcontroller.dart';
import 'package:mycart/controller/profilecontroller.dart';
import 'package:mycart/controller/services/firestore_service.dart';
import 'package:mycart/views/auth/login.dart';
import 'package:mycart/views/chat_screen/message_screen.dart';
import 'package:mycart/views/wishlistscreen/wishlish.dart';
import 'package:mycart/widgets/bg.dart';
import '../views/ordersscreen/order_screen.dart';


class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Profilecontroller());

    FirestoreServices.getCounts();

    return bg(
      Scaffold(
        backgroundColor: Colors.black45,
        body: StreamBuilder(
          stream: FirestoreServices.GetUser(currentUser?.email),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    //edit profile button
                  //  Padding(
                  //    padding: const EdgeInsets.all(8.0),
                    //  child: Align(
                  //      alignment: Alignment.topRight,
                   //     child: Icon(
                    //      Icons.edit,
                    //      color: whiteColor,
                    //    ),
                    //  ).onTap(() {

                      //  controller.namecontroller.text = data['name'];
                     //   controller.newpasscontroller.text = data['pass'];
                    //    Get.to(() => Editprofile(data: data));
                   //   }),
                  //  ),

                    45.heightBox,
                    //user details
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imgurl'] == '' ? Image.asset(imgprofile1,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                          :Image.network(
                            data['imgurl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .toString()
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['email']}".toString().text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white),
                              ),
                              onPressed: () async {
                                await Get.put(Authcontroller())
                                    .signoutMethod(context);
                                Get.offAll(() => Login());
                              },
                              child:
                                  logout.text.fontFamily(semibold).white.make())
                        ],
                      ),
                    ),

                    20.heightBox,
                    FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.redAccent),
                              ),
                            );
                          } else {
                            var countdata = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailcards(
                                    count: countdata[0].toString(),
                                    title: "In your Cart",
                                    width: context.screenWidth / 3.4),
                                detailcards(
                                    count: countdata[1].toString(),
                                    title: "In your WishList",
                                    width: context.screenWidth / 3.4),

                                detailcards(
                                    count: countdata[2].toString(),
                                    title: "Your Orders",
                                    width: context.screenWidth / 3.4),
                              ],
                            );
                          }
                        }),

                    //buttons section

                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profilebuttonlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => Order_Screen());
                                break;
                              case 1:
                                Get.to(() => Wishlis_Screen());
                                break;
                              case 2:
                                Get.to(() => Messages_Screen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profilebuttonlisticon[index],
                            width: 22,
                          ),
                          title: profilebuttonlist[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(EdgeInsets.all(12))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .make(),
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
