import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }

  Future queryData(String queryString) {
    return FirebaseFirestore.instance
        .collection('Popular Items')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
