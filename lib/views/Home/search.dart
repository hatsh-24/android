import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycart/consts/consts.dart';

import '../../Categories_screen/item_details.dart';

class Searchscreen extends StatelessWidget {
  final String? title;
   Searchscreen({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchproduct(title),
          builder: (context, AsyncSnapshot <QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                ),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No Products Found".text.white.makeCentered();
            }
            else{
              var data = snapshot.data!.docs;
              var filltered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
              
              return Padding(
                padding:  EdgeInsets.all(8.0),
                child: GridView(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300,

                ),
                children: filltered.mapIndexed((currentValue, index) =>
            Column(
            crossAxisAlignment: CrossAxisAlignment
                  .start,

            children: [
            Image.network(filltered[index]['p_image'][0], width: 150,height: 120,
            fit: BoxFit.cover,),
            10.heightBox,
            "${filltered[index]['p_name']}".text
                  .fontFamily(semibold).color(
            darkFontGrey).make(),
            10.heightBox,
            "${filltered[index]['p_price']}".text.fontFamily(bold)
                  .color(Colors.red).size(16)
                  .make()
            ],
            ).box.white.outerShadowMd.margin(EdgeInsets.symmetric(horizontal: 4)).padding(EdgeInsets.all(12)).make().onTap(() {
              Get.to(()=>Item_details(title:"${filltered[index]['p_name']}",data: filltered[index],),);
            }),
                ).toList(),),
              );
            }

          }),
    );
  }
}
