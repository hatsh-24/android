// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mycart/consts/consts.dart';


Widget Custom({String? title,String? hint,controller,ispass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.black.fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,

          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),


    ],
  );
}