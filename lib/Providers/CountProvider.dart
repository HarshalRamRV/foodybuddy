import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CountProvider with ChangeNotifier {
  getAddAndQuantity(int count, bool isTrue, String productName) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(productName)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  count = value.get("quantity"),
                  isTrue = value.get("isAdd"),
                }
            });
    notifyListeners();
  }
}
  //   getAddAndQuantity() {
  //   FirebaseFirestore.instance
  //       .collection("ReviewCart")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("YourReviewCart")
  //       .doc(widget.productName)
  //       .get()
  //       .then(
  //         (value) => {
  //           if (this.mounted)
  //             {
  //               if (value.exists)
  //                 {
  //                   setState(() {
  //                     count = value.get("quantity");
  //                     isTrue = value.get("isAdd");
  //                   })
  //                 }
  //             }
  //         },
  //       );
  // }