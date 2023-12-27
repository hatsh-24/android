import 'package:flutter/cupertino.dart';
import 'package:mycart/consts/consts.dart';

Widget logo(){
  return Image.asset(icAppLogo).box.white.size(77,77).padding(const EdgeInsets.all(8)).rounded.make();
}