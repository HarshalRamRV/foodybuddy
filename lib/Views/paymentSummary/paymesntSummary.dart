import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:foodybuddy/Views/ReviewCart.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:foodybuddy/Views/paymentSummary/orderItem.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentSummary extends StatefulWidget {
  PaymentSummary();

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  late Razorpay razorpay;
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentSucess);
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

  Future openCheckout(totalPrice) async {
    var options = {
      'key': 'rzp_test_0TNW4hYzaHgCAt',
      'amount': totalPrice * 100,
      'name': userPhoneNo,
      'description': 'Payment',
      'prefill': {'contact': userPhoneNo, 'email': 'test@razorpay.com'},
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
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double totalPrice = reviewCartProvider.getTotalPrice();
    setOrderDetails() async {
      await FirebaseFirestore.instance.collection("Orders").doc(userUid).set({
        "phone": userPhoneNo,
        "uid": userUid,
        "time": Provider.of<PaymentHelper>(context, listen: false)
            .deliveryTime
            .format(context)
      });
    }

    placeOrder() async {
      QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourReviewCart")
          .get();
      reviewCartValue.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection("Orders")
            .doc(userUid)
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
          .collection("YourReviewCart").snapshots().forEach((element) {
        for (QueryDocumentSnapshot snapshot in element.docs) {
          snapshot.reference.delete();
        }
      });

    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      bottomNavigationBar: ListTile(
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
                openCheckout(totalPrice).whenComplete(() {
                  setOrderDetails();
                  placeOrder();
                  deleteReviewCartData();
                });
                Navigator.of(context).pop();
              },
              maxwidth: 200,
              minwidth: 150)),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    totalPrice.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
