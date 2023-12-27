import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts/consts.dart';

class Wishlis_Screen extends StatelessWidget {
  const Wishlis_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:
            "My WishList".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.redAccent),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "You Like nothing?".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            "${data[index]['p_image'][0]}",
                            width: 100,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['p_name']}".toString().text.make(),
                          subtitle: "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(Colors.red)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite_sharp,
                            color: Colors.red,
                          ).onTap(() async {
                            await firestore
                                .collection(productcollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
