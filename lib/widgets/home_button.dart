import 'package:flutter/cupertino.dart';
import 'package:mycart/consts/consts.dart';

// ignore: non_constant_identifier_names
Widget Homebuttons({width, height, icon, String? title, onpress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
