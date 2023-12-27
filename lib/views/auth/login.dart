import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/authcontroller.dart';
import 'package:mycart/views/Home/home.dart';
import 'package:mycart/views/auth/signup.dart';
import 'package:mycart/widgets/bg.dart';
import 'package:mycart/widgets/button.dart';
import 'package:mycart/widgets/textf_button.dart';
import '../../consts/list.dart';


class Login extends StatelessWidget {
   Login({Key? key}) : super(key: key);

  var controller = Get.put(Authcontroller());
   var emailcontroller = TextEditingController();
   var passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bg(Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              const Icon(Icons.lock_person,size: 130,),
              15.heightBox,
              "Login in to $appname".text.fontFamily(bold).white.size(19).make(),
              15.heightBox,

              Obx(()=>
                 Column(
                  children: [
                   Custom(title: email,hint: emailhint,ispass: false,controller:  controller.emailcontroller),
                   10.heightBox,//for space
                   Custom(title: pass,hint: passhint,ispass: true,controller: controller.passcontroller),

                   Align( alignment: Alignment.centerRight ,child: TextButton(onPressed: (){}, child: forget.text.make() )),
                    5.heightBox,
                    //button login
                     controller.isloading.value ? CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                     ): mybutton(title: login,tcolr: whiteColor,onPress: ()async{
                       controller.isloading(true);

                       await controller.loginMethod(context: context).then((value){
                         if(value!=null){
                           VxToast.show(context, msg: "logged in");
                           Get.offAll(()=>MyHome());
                         }
                         else{
                           controller.isloading(false);
                         }
                       });
                      
                    }).box.width(context.screenWidth-50).make(),



                    10.heightBox,
                    newuser.text.color(fontGrey).make(),
                    10.heightBox,
                    //signup button
                    mybutton(title: signupl,tcolr: whiteColor,onPress: (){
                      Get.to(mysignup());
                    }).box.width(context.screenWidth-50).make(),

                    12.heightBox,
                    //login with button
                    loginwith.text.color(fontGrey).make(),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(social[index],width: 30,) ,
                        ),
                      ),),
                    ),



                  ],
                ).box.color(Colors.white30).rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).make(),
              )
            ],
          ),
        ),
      ),
    ));


  }
}
