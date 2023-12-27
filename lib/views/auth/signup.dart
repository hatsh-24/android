import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/authcontroller.dart';
import 'package:mycart/views/Home/Home_screen.dart';
import 'package:mycart/views/Home/home.dart';
import 'package:mycart/views/auth/login.dart';
import 'package:mycart/widgets/bg.dart';
import 'package:mycart/widgets/button.dart';
import 'package:mycart/widgets/textf_button.dart';
import 'package:get/get.dart';
import '../../consts/list.dart';
import '../../consts/strings.dart';

class mysignup extends StatefulWidget {
  const mysignup({Key? key}) : super(key: key);

  @override
  State<mysignup> createState() => _mysignupState();
}

class _mysignupState extends State<mysignup> {

  bool? ischeck = false;
  var controller = Get.put(Authcontroller());
  //text controller
  var namecon = TextEditingController();
  var emailecon = TextEditingController();
  var passcon = TextEditingController();
  var comfpasscon = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return bg(Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              Icon(Icons.person_outline,size: 100,),
              15.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(19).make(),
              15.heightBox,

              Column(
                children: [
                  Custom(title:name, hint:namehint,controller:namecon,ispass:false),
                  10.heightBox,//for space
                  Custom(title:email, hint:emailhint,controller:emailecon,ispass:false),
                  10.heightBox,//for space
                  Custom(title:pass, hint:passhint,controller:passcon,ispass:true),
                  10.heightBox,//for space
                  Custom(title:repass, hint:passhint,controller:comfpasscon,ispass: true),

                 // Align( alignment: Alignment.centerRight ,child: TextButton(onPressed: (){}, child: forget.text.make() )),
                  5.heightBox,

                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: ischeck,
                          onChanged: (newValue) {
                            setState(() {
                              ischeck = newValue;
                            });
                          },
                      ),
                      5.widthBox,
                      Expanded(
                        child: RichText(text: TextSpan(children:[
                        TextSpan(text: "I agree to the ",style: TextStyle(
                          fontFamily: regular,
                          color: fontGrey,

                        ),),
                          TextSpan(text: termandcondition,style: TextStyle(
                            fontFamily: regular,
                            color: Colors.redAccent,

                          ),),
                          TextSpan(text: " & ",style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,

                          ),),
                          TextSpan(text: privacyPolicy,style: TextStyle(
                            fontFamily: regular,
                            color: Colors.redAccent,

                          ))
                        ],
                        ),),
                      ),

                    ],
                  ),
                  10.heightBox,
                  //signup button
                  mybutton(title: signupl,tcolr:ischeck == true? redColor :lightGrey,onPress: ()async{
                    if(ischeck != false){
                      try{
                        await controller.signupMethod(context: context,email: emailecon.text,password: passcon.text).then((value){
                          return controller.storeUserData(
                            name: namecon.text,
                            pass: passcon.text,
                            email: emailecon.text,
                          );
                        }).then((value){
                        //  VxToast.show(context, msg: "Logged in Successfully!");
                          Get.offAll(()=>MyHome());
                        });
                      }catch(e){
                        auth.signOut();
                        VxToast.show(context, msg:e.toString());
                      }
                    }
                  }).box.width(context.screenWidth-50).make(),
                  10.heightBox,
                  //gesture detector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyuser.text.white.make(),
                        login.text.color(Colors.red).make().onTap(() {
                          Get.back();
                        })
                      ]
                  ),
                ],
              ).box.color(Colors.white30).rounded.padding(EdgeInsets.all(16)).width(context.screenWidth - 70).make()
            ],
          ),
        ),
      ),
    ));


  }
}
