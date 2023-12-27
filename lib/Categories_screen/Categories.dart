import 'package:flutter/material.dart';
import 'package:mycart/Categories_screen/cat_details.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/consts/strings.dart';
import 'package:mycart/controller/productcontroller.dart';
import 'package:mycart/widgets/bg.dart';
import 'package:get/get.dart';

class categorie extends StatelessWidget {
  const categorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return bg(
      Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categorieimg[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    "${categorieslist[index]}"
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                ).box.white.roundedSM.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  controller.getSubCategories(categorieslist[index]);
                  Get.to(()=>Cat_details(title: categorieslist[index],));
                });
              }),
        ),
      ),
    );
  }
}
