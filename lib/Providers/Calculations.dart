import 'package:flutter/cupertino.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cartData = 0;
  int get getCartData => cartData;
  addToCart(BuildContext context, dynamic data) async {
    cartData++;
    await Provider.of<ManageData>(context, listen: false)
        .submitData(context, data);
    notifyListeners();
  }

  removeFromCart(BuildContext context, dynamic data) async {
    cartData--;
    await Provider.of<ManageData>(context, listen: false)
        .submitData(context, data);
    notifyListeners();
  }
}
