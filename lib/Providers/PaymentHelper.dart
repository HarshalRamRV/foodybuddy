import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper with ChangeNotifier {
  
  TimeOfDay deliveryTime = TimeOfDay.now();
  
  Future selectTime(BuildContext context) async{
    // ignore: unused_local_variable
    final stelectedTime =  deliveryTime;
    notifyListeners();
  }
  handlePaymentSucess(BuildContext context,PaymentSuccessResponse paymentSuccessResponse) {
      return showResponse(context, paymentSuccessResponse.paymentId);}
  handlePaymentError(BuildContext context,PaymentFailureResponse paymentFailureResponse) {
    return showResponse(context, paymentFailureResponse.message);}
  handleExternalWallet(BuildContext context,ExternalWalletResponse externalWalletResponse) {
    return showResponse(context, externalWalletResponse.walletName);}
  showResponse(BuildContext context, String? response) { 
    return showModalBottomSheet(context: context, builder: (context) {
      return Container (height: 100.0,  width: 400.0,
        child: Text('The reponse is $response', style: TextStyle()), 
      ); // Container 
    }
    );
  }
}