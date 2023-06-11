import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/OrderStatus.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        automaticallyImplyLeading :false,
        centerTitle: true,
        foregroundColor: Color(0xFFF06623),
        backgroundColor: Colors.white,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getdata(context),
          ],
        ),
      ),
    );
  }
}
Widget getdata(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where("uid", isEqualTo: userUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return new Column(
                children: snapshot.data!.docs
                    .map((QueryDocumentSnapshot queryDocumentSnapshot) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          blurRadius: 5.0),
                    ]),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                child:  Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListTile(
                        onTap: () {
                          
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OrderStatus(
                                orderNo: int.parse((queryDocumentSnapshot.data()
                                        as dynamic)['orderNo']
                                    .toString().substring(1)),
                              ),
                            ),
                          );
                        },
                        leading: Icon(Icons.receipt_long,size: 35.0,color: Color.fromARGB(124, 240, 103, 35),),
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Order no",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                                (queryDocumentSnapshot.data()
                                        as dynamic)['orderNo']
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    )
              );
            }).toList());
          }
        },
      ),
    ),
  );
}
