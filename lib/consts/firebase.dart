import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User?currentUser = auth.currentUser;

//collection

const usersCollection = "users";

const productcollection = "products";

const cartcollection = "cart";

const chatscollection = 'chats';

const messagecollection = 'messages';

const orderscolection ="orders";