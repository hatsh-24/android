import 'package:mycart/consts/consts.dart';
import 'package:mycart/consts/list.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/views/Home/Home_screen.dart';
import 'package:mycart/views/Home/home.dart';

import '../widgets/button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor:Vx.gray200,
        bottomNavigationBar: SizedBox(
          height: 60,
          child:

          controller.placingorder.value ? Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
          ) : mybutton(
              bclor: color(Vx.red50),
              onPress: () async{

                controller.placeMyorder(orderpaymentMethod: paymentmethods[controller.paymentindex.value],totalAmount: controller.totalP.value);
                
                await controller.clearCart();
                VxToast.show(context, msg: "Order Placed Successfully.");
                Get.offAll(MyHome());
              },
              title: "Place My Order",
              tcolr: whiteColor
          ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),

         body: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Column(
             children: [
               GridView.builder(
                   shrinkWrap: true,
                   itemCount: 2,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       mainAxisSpacing: 8,
                       crossAxisSpacing: 8,
                       mainAxisExtent: 200),
                   itemBuilder: (context, index) {
                     return Obx(
                       ()=> Column(
                         children: [
                           GestureDetector(
                             child: Stack(
                               alignment: Alignment.topRight,
                               children: [
                                 Image.asset(
                                   paymentmethodsimg[index],
                                   height: 100,
                                   width: 200,
                                   colorBlendMode: controller.paymentindex.value == index ? BlendMode.darken : BlendMode.color,
                                   color: controller.paymentindex.value == index ? Colors.black.withOpacity(0.4) : Colors.transparent,
                                   fit: BoxFit.cover,
                                 ),
                               controller.paymentindex.value == index ?  Checkbox(
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                   activeColor: Colors.green,
                                   value: true, onChanged: (value){},):Container(),
                               ],
                             ),
                             onTap: (){
                               controller.changepayindex(index);
                             },
                           ),
                           10.heightBox,
                           paymentmethods[index]
                               .text
                               .color(darkFontGrey)
                               .fontFamily(bold)
                               .align(TextAlign.center)
                               .make(),
                         ],
                       ).box.roundedSM.clip(Clip.antiAlias).make().onTap(() {
                       }),
                     );
                   })
             ],


      ),
         ),
      ),
    );
  }
}
