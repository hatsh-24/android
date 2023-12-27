import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/views/Home/home.dart';
import 'package:mycart/views/auth/login.dart';
import 'package:mycart/widgets/logo.dart';


class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  // create method change screen
  change(){
    Future.delayed(Duration(seconds: 2),(){
    //  Get.to(()=>Login());
      auth.authStateChanges().listen((User? user) {
        if(user== null && mounted){
          Get.to(()=> Login());
        }else{
          Get.to(()=>MyHome());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    change();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Column(
        children: [
           Align(alignment: Alignment.topLeft, child: Image.asset(icSplashBg, width: 300)),
           20.heightBox,
           logo(),
           10.heightBox,
           appname.text.fontFamily(bold).size(22).white.make(),
           5.heightBox,
           appversion.text.white.make(),

           Spacer(),
           credits.text.white.fontFamily(semibold).make(),
           30.heightBox,
        ],
      ),
    );
  }
}
