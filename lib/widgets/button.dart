
import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';

Widget mybutton({onPress,bclor,tcolr,String? title}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          padding: const EdgeInsets.all(17)
      ),
      onPressed: onPress,
      child: title!.text.color(tcolr).fontFamily(bold).make());
}