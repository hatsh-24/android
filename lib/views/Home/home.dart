import 'package:flutter/material.dart';
import 'package:mycart/Cart_Screen/Cart.dart';
import 'package:mycart/Profile_Screen/profile.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/home_controller.dart';
import 'package:mycart/views/Home/Home_screen.dart';
import 'package:mycart/widgets/exitdialog.dart';

import '../../Categories_screen/Categories.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init controller
    var controller = Get.put(Homecontroller());

    var navitem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];

    var navbody = [
      Home_screen(),
      categorie(),
      Cart(),
      Profile()
    ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(
            barrierDismissible: false,
            context: context, builder: (context)=>exiteDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
            ()=> Expanded(
                child: navbody.elementAt(controller.currentNavindex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentNavindex.value,
              selectedItemColor: Colors.orange,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white38,
              onTap: (value) {
                controller.currentNavindex.value = value;
              },
              items: navitem),
        ),
      ),
    );
  }
}
