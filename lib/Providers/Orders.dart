// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:foodybuddy/Models/reviewCartModal.dart';


// class OrdersProvider with ChangeNotifier {

//   List<ReviewCartModel> reviewCartDataList = [];
//   void getOrdersData() async {
//     List<ReviewCartModel> newList = [];

//     QuerySnapshot reviewOrdersValue = await FirebaseFirestore.instance
//         .collection("Orders")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("MyOrders")
//         .get();
//     reviewOrdersValue.docs.forEach((element) {
//       ReviewCartModel reviewCartModel = ReviewCartModel(
//         category: element.get("category"),
//         image: element.get("image"),
//         name: element.get("name"),
//         price: element.get("price"),
//         quantity: element.get("quantity"),      
//         );
//       newList.add(reviewCartModel);
//     });
//     reviewCartDataList = newList;
//     notifyListeners();
//   }

//   List<ReviewCartModel> get getReviewCartDataList {
//     return reviewCartDataList;
//   }


// //// TotalPrice  ///

// getTotalPrice(){
//   double total = 0.0;
//   reviewCartDataList.forEach((element) { 
//     total += element.price * element.quantity;
    
//   });
//   return total;
// }


// ////////////// ReviCartDeleteFunction ////////////
//   reviewCartDataDelete(name) {
//     FirebaseFirestore.instance
//         .collection("Orders")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("MyOrders")
//         .doc(name)
//         .delete();
//         notifyListeners();
//   }
// }