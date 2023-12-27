import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/controller/home_controller.dart';

class CartController extends GetxController{
 var totalP = 0.obs;





 //text controller
 var addressController =  TextEditingController();
 var cityController =  TextEditingController();
 var stateController =  TextEditingController();
 var postalcodeController =  TextEditingController();
 var phoneController =  TextEditingController();

 var paymentindex = 0.obs;

 late dynamic productsnapshot;
 var products =[];

 var vendors = [];


 var placingorder = false.obs;


 changepayindex(index){

   paymentindex.value = index;
 }

 calculate(data){
   totalP.value=0;
   for(var i = 0; i<data.length;i++){
     totalP.value = totalP.value + int.parse(data[i]["tprice"].toString());
   }
 }



 placeMyorder({required orderpaymentMethod,required totalAmount})async{

   placingorder(true);


   await getproductdetails();



   await firestore.collection(orderscolection).doc().set({
     'order_no':"001",
     'order_date':FieldValue.serverTimestamp(),
     'order_by':currentUser!.uid,
     'order_by_name':Get.put(Homecontroller()).username,
     'order_by_email':currentUser!.email,
     'order_by_address':addressController.text,
     'order_by_state':stateController.text,
     'order_by_city':cityController.text,
     'order_by_phone':phoneController.text,
     'order_by_postalcode':postalcodeController.text,
     'shipping_method':"Home Delivery",
     'payment_method':orderpaymentMethod,
     'order_placed':true,
     'Total Amount': totalAmount,
     'orders':FieldValue.arrayUnion(products),
     'order_confirmed':false,
     'order_delivered':false,
     'order_on_delivery':false,
     'vendors':FieldValue.arrayUnion(vendors)

   });
   placingorder(false);
 }

 getproductdetails(){


   products.clear();
   vendors.clear();
   for(var i =0; i < productsnapshot.length;i++){

     products.add({
       'color':productsnapshot[i]['color'],
       'img':productsnapshot[i]['img'],
       'qty':productsnapshot[i]['qty'],
       'title':productsnapshot[i]['title'],
       'vendore_id':productsnapshot[i]['vendore_id'],
       'tprice':productsnapshot[i]['tprice'],
       
     });
     vendors.add(productsnapshot[i]['vendore_id']);
   }


 }



 //cart clear method

clearCart(){
   for(var i = 0; i<productsnapshot.length;i++){
     firestore.collection(cartcollection).doc(productsnapshot[i].id).delete();
   }
}




}