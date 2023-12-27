

import 'package:flutter/services.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/widgets/button.dart';

Widget exiteDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are You sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            mybutton(
              title: "Yes",
              tcolr: whiteColor,
              bclor: redColor,
              onPress: (){
                SystemNavigator.pop();
              }
            ),
            mybutton(
                title: "No",
                tcolr: whiteColor,
                bclor: redColor,
                onPress: (){
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ],
    ).box
        .color(lightGrey).roundedSM.padding(EdgeInsets.all(12))
        .make(),
  );
}