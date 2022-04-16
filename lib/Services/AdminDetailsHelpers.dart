import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDetailsHelpers with ChangeNotifier {
  bool orderStatus = false;
  bool orderConfirmation = false;
  setOrderStatusData(orderNo) async {
    orderStatus = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderNo)
        .get()
        .then((value) {
      return value
          .data()!['orderStatus']; // Access your after your get the data
    });
    notifyListeners();
  }

  bool get getOrderStatus {
    return orderStatus;
  }

  Future fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Orders")
        .where("orderStatus", isEqualTo: false)
        .get();
    return querySnapshot.docs;
  }

  Future fetchDataItems(orderNo) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderNo)
        .collection("myOrders")
        .get();
    return querySnapshot.docs;
  }

  Future setOrderStatus(
      BuildContext context, dynamic orderId, dynamic orderStatus) async {
    return FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderId)
        .update({'orderStatus': orderStatus});
  }
    Future fetchCatData(String collection, String category) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).where("category",isEqualTo:category.toString() ).get();
    return querySnapshot.docs;
  }
    setOrderConfirmation(orderNo) async {
    orderConfirmation = await FirebaseFirestore.instance
        .collection('Orders')
        .doc("#$orderNo")
        .get()
        .then((value) {
      return value
          .data()!['orderConfirmation']; // Access your after your get the data
    });
    notifyListeners();
  }

  bool get getOrderConfirmation {
    return orderConfirmation;
  }
}
