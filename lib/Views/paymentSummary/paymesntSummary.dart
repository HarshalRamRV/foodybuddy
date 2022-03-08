import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
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
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': totalPrice * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
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
                openCheckout(totalPrice);
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
