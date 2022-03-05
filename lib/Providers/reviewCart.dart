import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';


class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    required String name,
    required String image,
    required String category,
    required int price,
    required int quantity,
    }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(name)
        .set(
      {
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "category":category,
        "isAdd":true,
      },
    );
  }

void updateReviewCartData({
    required String name,
    required String image,
    required String category,
    required int price,
    required int quantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(name)
        .update(
      {
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "category":category,
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        category: element.get("category"),
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
        quantity: element.get("quantity"),      
        );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }


//// TotalPrice  ///

getTotalPrice(){
  double total = 0.0;
  reviewCartDataList.forEach((element) { 
    total += element.price * element.quantity;
    
  });
  return total;
}


////////////// ReviCartDeleteFunction ////////////
  reviewCartDataDelete(name) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(name)
        .delete();
        notifyListeners();
  }
}