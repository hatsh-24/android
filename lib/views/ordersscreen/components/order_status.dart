import 'package:mycart/consts/consts.dart';

Widget orderStatus({icon,color,title,showdone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),

    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showdone ? const Icon(
            Icons.done,
            color: Colors.redAccent,
          ):Container(),
        ],
      ),
    ),
  );
}
