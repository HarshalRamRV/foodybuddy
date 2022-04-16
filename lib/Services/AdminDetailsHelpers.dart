import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDetailsHelpers with ChangeNotifier {
  bool orderStatus = false;

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
}
