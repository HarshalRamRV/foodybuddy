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
  
  Future<int> countDocuments(String collection) async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(collection)
        .get();
    return querySnapshot.docs.length;
  }

  Future submitData(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('myOrders')
        .doc(Provider.of<AuthProvider>(context, listen: false).getUid)
        .set(data);
  }

  Future deleteData(BuildContext context, data1) {
    return FirebaseFirestore.instance
        .collection('myOrders')
        .doc(Provider.of<AuthProvider>(context, listen: false).getUid)
        .delete();
  }
}
