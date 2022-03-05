// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:foodybuddy/Services/ManageData.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cartData = 0;
  int ItemQuant = 0;
  bool newItem = true;
  int get getCartData => cartData;
  bool get getNewItem => newItem;
  
  void setItem() {
    newItem = true;
  }
  addItem() {
    newItem = false;
    notifyListeners();
  }
    minusItem() {
    newItem = true;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (cartData <= 50) {
      cartData++;
    }
    await Provider.of<ManageData>(context, listen: false)
        .submitData(context, data);
    notifyListeners();
  }

  removeFromCart(BuildContext context, dynamic data1) async {
    if (cartData != 0) {
      cartData--;
    }
    await Provider.of<ManageData>(context, listen: false)
        .deleteData(context, data1);
    notifyListeners();
  }


}
