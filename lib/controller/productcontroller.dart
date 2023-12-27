import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';
import 'package:mycart/models/categorymodel.dart';

class ProductController extends GetxController {
  var Quantity = 0.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;

  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle
        .loadString("lib/controller/services/categories_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changecolor(index) {
    colorindex = index;
  }

  increasQuantity(totalQuantity) {
    if (Quantity.value < totalQuantity) {
      Quantity.value++;
    }
  }

  decreasQuantity() {
    if (Quantity.value > 0) {
      Quantity.value--;
    }
  }

  calculatetotalprice(price) {
    totalprice.value = price * Quantity.value;
  }

  addTocart({title, img, sellername, color, qty, tprice, context,vendoreID}) async {
    await firestore.collection(cartcollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "color": color,
      "qty": qty,
      "tprice": tprice,
      "added_by": currentUser!.uid,
      "vendore_id":vendoreID,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalprice.value = 0;
    Quantity.value = 0;
    colorindex.value = 0;
  }

  addtoWishlist(docId,context) async {
    await firestore.collection(productcollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added To Wishlist");
  }

  removefromWishlist(docId,context) async {
    await firestore.collection(productcollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed From Wishlist");

  }

  checkifFav(data) async{
   if(data['p_wishlist'].contains(currentUser!.uid)){
     isFav(true);
   }
   else{
     isFav(false);
   }
  }
}
