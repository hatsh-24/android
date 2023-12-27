import 'package:mycart/Cart_Screen/payment_screen.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/cart_controller.dart';
import 'package:mycart/widgets/button.dart';
import 'package:mycart/widgets/textf_button.dart';


class ShippingDetail extends StatelessWidget {
  const ShippingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   // var controller = Get.find<CartController>();
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: Vx.gray200,
      appBar: AppBar(
        title: "Shipping Info:".text.fontFamily(semibold).color(darkFontGrey).make(),

      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: mybutton(
            bclor: color(Vx.red50),
            onPress: () {

              if(controller.addressController.text.length>10){
                Get.to(()=>PaymentMethod());

              }else{
                VxToast.show(context, msg: "Please Fill the Form");
              }

            },
            title: "Continue",
            tcolr: whiteColor
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Custom(hint: "Address",ispass: false,title:"Address",controller: controller.addressController),
            Custom(hint: "city",ispass: false,title:"city" ,controller: controller.cityController),
            Custom(hint: "State",ispass: false,title: "State",controller: controller.stateController),
            Custom(hint: "Postal Code",ispass: false,title: "Postal Code",controller: controller.postalcodeController),
            Custom(hint: "Phone",ispass: false,title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
