import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Count extends StatefulWidget {
  String productName;
  String productImage;
  String productCategory;
  int productPrice;

  Count({
    required this.productName,
    required this.productCategory,
    required this.productImage,
    required this.productPrice,
  });
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(widget.productName)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("quantity");
                      isTrue = value.get("isAdd");
                    })
                  }
                  else{
                    setState(() {
                      isTrue = false;
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productName);
                    } else if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                      image: widget.productImage,
                      name: widget.productName,
                      price: widget.productPrice,
                      category: widget.productCategory,
                      quantity: count,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4,4,4,4),
                    child: Icon(
                        Icons.remove,
                        size: 18,
                        color: Color(0xffd0b84c),
                      ),
                  ),
                  
                ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(4,4,4,4),
                   child: Text(
                      "$count",
                      style: TextStyle(
                        color: Color(0xffd0b84c),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 ),
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      image: widget.productImage,
                      name: widget.productName,
                      price: widget.productPrice,
                      quantity: count,
                      category: widget.productCategory,
                    );
                  },
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(4,4,4,4),
                    child: Icon(
                        Icons.add,
                        size: 18,
                        color: Color(0xffd0b84c),
                      ),
                  ),
                  ),
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    image: widget.productImage,
                    name: widget.productName,
                    price: widget.productPrice,
                    quantity: count,
                    category: widget.productCategory,
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}