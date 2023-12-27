import 'package:get/get.dart';
import 'package:mycart/consts/consts.dart';

class Homecontroller extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }


  var searchcontroller = TextEditingController();

  var username ='';

  var currentNavindex = 0.obs;

  getUsername() async{
   var n = await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });

    username = n;

  }




}