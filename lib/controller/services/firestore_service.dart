import 'package:mycart/consts/consts.dart';

class FirestoreServices {
  static GetUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('email', isEqualTo: uid)
        .snapshots();
  }

  //get product

  static getProducts(category) {
    return firestore
        .collection(productcollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //get cart details

  static getCart(uid) {
    return firestore
        .collection(cartcollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //get show msg
  static getChatMessages(docId) {
    return firestore
        .collection(chatscollection)
        .doc(docId)
        .collection(messagecollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }

//delete
  static delete(docId) {
    return firestore.collection(cartcollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(orderscolection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection(productcollection)
        .where("p_wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatscollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartcollection)
          .where('added_by', isEqualTo: currentUser!.uid).get().then((value){
           return value.docs.length;
      }),
      firestore
          .collection(productcollection)
          .where('p_wishlist', arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore
          .collection(orderscolection)
          .where('order_by', isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
    ]);
    return res;
  }


  static allProducts(){
    return firestore
        .collection(productcollection)
        .snapshots();

  }
  //
  static getfeaturedproduct(){
    return firestore
        .collection(productcollection).where('is_featured',isEqualTo: true)
        .get();
  }

  static searchproduct(title){
    return firestore.collection(productcollection).where('p_name',isLessThanOrEqualTo: title).get();
  }


}
