import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const userCollection = "users";
const productsCollection = "products";
const cartCollection = "cart";
const chatsCollection = 'chats';
const messagesCollection = 'messages';
const ordersCollection = 'orders';
