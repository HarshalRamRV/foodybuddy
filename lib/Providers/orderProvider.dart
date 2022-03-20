import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';
import 'package:foodybuddy/Views/OrderStatus.dart';

class OrderProvider with ChangeNotifier {
  String orderNo = "";
  String orderStatus = "";
  String fee = "";
  String totalNoFee = "";
  List<ReviewCartModel> ordersDataList = [];
  void getOrderData(orderNo) async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot ordersValue = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderNo)
        .collection("myOrders")
        .get();
    ordersValue.docs.forEach((element) {
      ReviewCartModel ordersModel = ReviewCartModel(
        category: element.get("category"),
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
        quantity: element.get("quantity"),
      );
      newList.add(ordersModel);
    });
    ordersDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getOrdersDataList {
    return ordersDataList;
  }

  getTotalPrice() {
    double total = 0.0;
    ordersDataList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  setOrderStatus(orderNo) async {
    orderStatus = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderNo.toString())
        .get()
        .then((value) {
      return value
          .data()!['orderStatus']; // Access your after your get the data
    });
    notifyListeners();
  }

  String get getOrderStatus {
    return orderStatus;
  }

  setFee(orderNo) async {
    fee = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderNo.toString())
        .get()
        .then((value) {
      return value.data()!['fee']; // Access your after your get the data
    });
    notifyListeners();
  }

  String get getFee {
    return fee;
  }

  setTotalNoFee(orderNo) async {
    totalNoFee = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderNo.toString())
        .get()
        .then((value) {
      return value
          .data()!['totalNoFee']; // Access your after your get the data
    });
    notifyListeners();
  }
  String get getTotalNoFee {
    return totalNoFee;
  }
}