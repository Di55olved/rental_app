import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_app/Apis/user.dart';

class Api {
  static final auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> createUser() async {
    final user = Users(
        id: auth.currentUser!.uid,
        email: auth.currentUser!.email.toString(),
        image: auth.currentUser!.photoURL.toString(),
        balance: 0,
        status: 'Active',
        strikes: 0,
        name: auth.currentUser!.displayName.toString());

    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }
}
