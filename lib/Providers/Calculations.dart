// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cartData = 0;
  int ItemQuant = 0;
  int get getCartData => cartData;
  int get getItemQuant => ItemQuant;

  addItemQuant() {
    ItemQuant++;
    notifyListeners();
  }

  minusItemQuant() {
    ItemQuant--;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    cartData++;
    await Provider.of<ManageData>(context, listen: false)
        .submitData(context, data);
    notifyListeners();
  }

  removeFromCart(BuildContext context, dynamic data1) async {
    cartData--;
    await Provider.of<ManageData>(context, listen: false)
        .deleteData(context, data1);
    notifyListeners();
  }
}
