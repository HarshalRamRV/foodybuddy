import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';

class OrderProvider with ChangeNotifier {
  bool? orderConfirmation = false;
  int orderNoInt = 0;
  String orderNo = "";
  bool? orderStatus = false;
  double? fee = 0;
  double? totalNoFee = 0;
  List<ReviewCartModel> ordersDataList = [];
  void getOrderData(orderNo) async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot ordersValue = await FirebaseFirestore.instance
        .collection("Orders")
        .doc("#$orderNo")
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
        .doc("$orderNo")
        .get()
        .then((value) {
      return value
          .data()?['orderStatus']; // Access your after your get the data
    });
    notifyListeners();
  }

  bool? get getOrderStatus {
    return orderStatus;
  }

  setOrderConfirmation(orderNo) async {
    orderConfirmation = await FirebaseFirestore.instance
        .collection('Orders')
        .doc("$orderNo")
        .get()
        .then((value) {
      return value
          .data()?['orderConfirmation']; // Access your after your get the data
    });
    notifyListeners();
  }

  bool? get getOrderConfirmation {
    return orderConfirmation;
  }

  setFee(orderNo) async {
    fee = await FirebaseFirestore.instance
        .collection('Orders')
        .doc("$orderNo")
        .get()
        .then((value) {
      return value.data()?['fee']; // Access your after your get the data
    });
    notifyListeners();
  }

  double? get getFee {
    return fee;
  }

  Future setTotalNoFee(orderNo) async {
    totalNoFee = await FirebaseFirestore.instance
        .collection('Orders')
        .doc("$orderNo")
        .get()
        .then((value) {
      return value.data()?['totalNoFee']; // Access your after your get the data
    });
    notifyListeners();
  }

  double? get getTotalNoFee {
    return totalNoFee;
  }
  Future setOrderConfirmationTrue(
      BuildContext context, dynamic orderId, dynamic orderConfirmation) async {
    return FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderId)
        .update({'orderConfirmation': orderConfirmation});
  }

}
