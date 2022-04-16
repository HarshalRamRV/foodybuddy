import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Adminpanel/OrderPage.dart';
import 'package:foodybuddy/Services/AdminDetailsHelpers.dart';
import 'package:foodybuddy/Views/auth_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key? key}) : super(key: key);
  static const routeArgs = '/admin-screen';

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        automaticallyImplyLeading :false,
        actions: [
          IconButton(
            icon: Icon(EvaIcons.logOutOutline),
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('uid');
              sharedPreferences.remove('phoneNumber');
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed(AuthScreen.routeArgs);
            },
          )
        ],
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
    // Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       IconButton(
    //         icon: Icon(EvaIcons.logOutOutline),
    //         onPressed: () async {
    //           SharedPreferences sharedPreferences =
    //               await SharedPreferences.getInstance();
    //           sharedPreferences.remove('uid');
    //           sharedPreferences.remove('phoneNumber');
    //           Navigator.of(context, rootNavigator: true)
    //               .pushReplacementNamed(AuthScreen.routeArgs);
    //         },
    //       )
    //     ],
    //     centerTitle: true,
    //     title: Text('Orders',
    //         style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 28.0,
    //             fontWeight: FontWeight.bold)),
    //   ),
    //   body: Stack(
    //     children: [
    //       getdata(context),
    //     ],
    //   ),
    // );
  }
}

Widget getdata(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 2000.0, minHeight: 200.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Orders")
            .where("orderStatus", isEqualTo: false)
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
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OrderPage(
                                orderNo: (queryDocumentSnapshot.data()
                                        as dynamic)['orderNo']
                                    .toString(),
                                queryDocumentSnapshot: queryDocumentSnapshot,
                              ),
                            ),
                          );
                        },
                        subtitle: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Phone no",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                                (queryDocumentSnapshot.data()
                                        as dynamic)['phone']
                                    .toString()
                                    .substring(3),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
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
                    )),
              );
            }).toList());
          }
        },
      ),
    ),
  );
}
