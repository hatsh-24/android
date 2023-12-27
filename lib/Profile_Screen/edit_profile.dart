import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycart/controller/profilecontroller.dart';
import 'package:mycart/widgets/bg.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/widgets/button.dart';
import 'package:mycart/widgets/textf_button.dart';

class Editprofile extends StatelessWidget {

  final dynamic data;
  final String? username;

  const Editprofile({Key? key, this.data,this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<Profilecontroller>();
   

   // controller.oldpasscontroller.text = data['pass'];

    return bg(Scaffold(
      appBar: AppBar(),
      body: Obx(
        ()=> SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              controller.profileImgpath.isEmpty ?
              Image.asset(
                imgprofile1,
                width: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make()
                 : Image.file(File(controller.profileImgpath.value),
                  width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),



              10.heightBox,
              mybutton(title: "Change", tcolr: whiteColor, onPress: (){
               controller.changeImage(context);

                //controller.changeImage(context);
                //controller.updatweprofile(name: controller.newpasscontroller.text,pass: controller.newpasscontroller.text);
              }),
              20.heightBox,
              Custom(controller: controller.namecontroller,title: data['name'], hint:  data['name'], ispass: false),
              Custom(controller: controller.newpasscontroller,title: pass, hint: passhint, ispass: true),
              Custom(controller: controller.oldpasscontroller,title: pass, hint: passhint, ispass: true),
              10.heightBox,
            controller.isloadingtf.value ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.redAccent),
              ),
            ):

            SizedBox(
                width: context.screenWidth -60,
                  child: mybutton(title: "Save Change", tcolr: whiteColor, onPress: ()async{

                    controller.isloadingtf(true);

                    if(controller.profileImgpath.value.isNotEmpty){
                      await  controller.uploadProfileImage();
                    }else{
                      controller.profileimagelink = data['imageurl'];
                    }
                    if(controller.snspshotdata['password'] == controller.oldpasscontroller.text){
                      await controller.changeAuthPassword(
                          email: controller.snspshotdata['email'],
                          password: controller.oldpasscontroller.text,
                          newpassword: controller.newpasscontroller.text
                      );

                      await controller.updatweprofile(
                        name: controller.namecontroller.text,
                        imgurl: controller.profileimagelink,
                        pass: controller.newpasscontroller.text,
                      );
                      VxToast.show(context, msg: "Updated");

                    }else if(controller.oldpasscontroller.text.isEmptyOrNull &&  controller.newpasscontroller.text.isEmptyOrNull)
                    {
                      await controller.updatweprofile(
                        name: controller.namecontroller.text,
                        imgurl: controller.profileimagelink,
                        pass: controller.snspshotdata['password'],
                      );
                    }
                    else{
                      VxToast.show(context, msg: "Wrong Password");
                      controller.isloadingtf(false);
                    }





                  })),

            ],
          ).box.gray300.roundedSM.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top:50,left: 12,right:12 )).make(),
        ),
      ),
    ));
  }
}
