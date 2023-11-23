import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/Apis/api.dart';

class MiscAttributesMethods extends ChangeNotifier {
  Map<String, dynamic> userData = {};

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(Api.auth.currentUser!.uid)
          .get();

      userData = documentSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      log('Error: $e');
    }
    notifyListeners();
  }

  void setDisplayName(String value) {
    if (value != 'null') {
      userData['name'] = value;
    }
    notifyListeners();
  }

  void setPhotoURL(String value) {
    if (value != 'null') {
      userData['image'] = value;
    }
    notifyListeners();
  }
}
