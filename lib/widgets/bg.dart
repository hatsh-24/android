import 'package:mycart/consts/consts.dart';

Widget bg(Widget? child){
  return Container(
    decoration: const BoxDecoration(
      //image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill),
        color: Vx.gray300
    ),
    child: child,
  );
}