import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
import 'package:foodybuddy/Views/Detailedpage.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatinActionButton(),
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Color(0xFFF06623),
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [MiddleHelpers().getdata(context, 'myOrders')],
        ),
      ),
    );
  }

  Widget cartData() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('myOrders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/foodanimation.json'),
            );
          } else {
            // return new ListView(
            //     children: snapshot.data!.docs
            //         .map((DocumentSnapshot documentSnapshot) {
            //   return Container();
            // }).toList());
            return new ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2.0,
                              blurRadius: 5.0),
                        ]),
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: SizedBox(
                                child: Image.network(
                                  snapshot.data?.docs[index]['image'],
                                  width: 125.0,
                                  height: 125.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 215.0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 8.0, 8.0, 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?.docs[index]['name'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data?.docs[index]['category'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rupeeSign,
                                          size: 14.0,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['price']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 65.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffF06623),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 2.0,
                                        blurRadius: 5.0),
                                  ]),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: DetailedScreen(
                                              queryDocumentSnapshot:
                                                  snapshot.data!.docs[index]),
                                          type: PageTransitionType.fade));
                                },
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget floatinActionButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF06623)),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 107.0, vertical: 15.0)),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
        onPressed: () {},
        child: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      Stack(children: [
        FloatingActionButton(
          backgroundColor: Color(0xFFF06623),
          onPressed: () {},
          child: Icon(
            Icons.account_balance_wallet,
            size: 28.0,
          ),
        ),
      ])
    ]);
  }
}
