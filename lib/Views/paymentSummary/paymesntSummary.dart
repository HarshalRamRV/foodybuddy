import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:foodybuddy/Views/OrderStatus.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:foodybuddy/Views/paymentSummary/orderItem.dart';
import 'package:foodybuddy/widgets/ItemWidget.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentSummary extends StatefulWidget {
  PaymentSummary();

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  Razorpay razorpay = Razorpay();
  var orderNo;
  var fee;
  var totalPrice;
  var orderTotal;
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false)
            .handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlePaymentSucess(PaymentSuccessResponse response) async {
    Provider.of<PaymentHelper>(context, listen: false).setOrderNumber();
    orderNo = Provider.of<PaymentHelper>(context, listen: false).getOrderNo;
    print(orderNo);
    print("Payment Success");
    setOrderDetails(orderNo, fee, totalPrice);
    placeOrder(orderNo);
    deleteReviewCartData();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OrderStatus(
        orderNo: orderNo,
      ),
    ));
  }

  setOrderDetails(orderNo, fee, totalNoFee) async {
    await FirebaseFirestore.instance.collection("Orders").doc("#$orderNo").set({
      "orderStatus": false,
      "orderConfirmation": false,
      "fee": fee,
      "totalNoFee": totalNoFee,
      "orderNo": "#$orderNo",
      "phone": userPhoneNo,
      "total": orderTotal,
      "uid": userUid,
      "time": Provider.of<PaymentHelper>(context, listen: false)
          .deliveryTime
          .format(context)
    });
  }

  placeOrder(orderNo) async {
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("Orders")
          .doc("#$orderNo")
          .collection("myOrders")
          .add({
        'image': element.get("image"),
        'name': element.get("name"),
        'price': element.get("price"),
        'category': element.get("category"),
        'quantity': element.get("quantity")
      });
    });
  }

  deleteReviewCartData() async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot documentSnapshot in snapshot.docs) {
        documentSnapshot.reference.delete();
      }
    });
  }

  Future openCheckout(totalPlusFee) async {
    var options = {
      'key': 'rzp_test_0TNW4hYzaHgCAt',
      'amount': totalPlusFee * 100,
      'name': userPhoneNo.toString().substring(3),
      'description': 'Payment',
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PaymentHelper>(context, listen: false).setOrderNumber();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    totalPrice = reviewCartProvider.getTotalPrice();
    fee = (((totalPrice / 100 * 2) / 100 * 18) + (totalPrice / 100 * 2))
        .roundToDouble();
    double totalPlusFee = (totalPrice + fee).roundToDouble();
    orderTotal = totalPlusFee.roundToDouble();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Cart",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      bottomNavigationBar: reviewCartProvider.getReviewCartDataList.isEmpty
          ? ListTile()
          : ListTile(
              title: Text("Total Amount"),
              subtitle: Text(
                "$totalPrice",
                style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              trailing: RoundedButton(
                  title: "Place Order",
                  onPressed: () async {
                    openCheckout(totalPlusFee.roundToDouble())
                        .whenComplete(() {});
                  },
                  maxwidth: 250,
                  minwidth: 200)),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: GestureDetector(
                  onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed(Mainscreen.routeArgs);                  },
                  child: Lottie.asset('assets/lf30_editor_w5sweoxp.json',repeat: false)),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // ExpansionTile(
                      //   initiallyExpanded: true,
                      //   textColor: Color(0xFFF06623),
                      //   iconColor: Color(0xFFF06623),
                      //   children:
                      //       reviewCartProvider.getReviewCartDataList.map((e) {
                      //     return OrderItem(
                      //       e: e,
                      //     );
                      //   }).toList(),
                      //   title: Text(
                      //       "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                      // ),
                      Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviewCartProvider.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  ReviewCartModel data =
                      reviewCartProvider.getReviewCartDataList[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ItemWidget(
                        img: data.image,
                        itemName: data.name,
                        price: data.price.toString(),
                        category: data.category,
                      ),
                    ],
                  );
                },
              ),
            ),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "Bill Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "item Total",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        trailing: Text(
                          totalPrice.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "Taxes and Charges",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        trailing: Text(
                          fee.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "To Pay",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        trailing: Text(
                          orderTotal.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Divider(),
                      // ListTile(
                      //   leading: Text("Payment Options"),
                      // ),
                      // RadioListTile(
                      //   value: AddressTypes.OnlinePayment,
                      //   groupValue: myType,
                      //   title: Text("OnlinePayment"),
                      //   onChanged: (AddressTypes value) {
                      //     setState(() {
                      //       myType = value;
                      //     });
                      //   },
                      //   secondary: Icon(
                      //     Icons.devices_other,
                      //     color: Colors.amber,
                      //   ),
                      // )
                    ],
                  );
                },
              ),
            ),
    );
  }
}
