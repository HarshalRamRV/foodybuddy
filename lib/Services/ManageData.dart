import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ManageData extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future fetchData(String collection) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }
  
  Future fetchCatData(String collection, String category) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).where("category",isEqualTo:category.toString() ).get();
    return querySnapshot.docs;
  }
}
