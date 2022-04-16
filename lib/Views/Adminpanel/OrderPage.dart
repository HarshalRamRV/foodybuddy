// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Views/Adminpanel/AdminHomepage.dart';
import 'package:foodybuddy/Services/AdminDetailsHelpers.dart';
import 'package:foodybuddy/widgets/ItemWidget.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  final orderNo;
  final QueryDocumentSnapshot queryDocumentSnapshot;
  OrderPage({required this.orderNo, required this.queryDocumentSnapshot});
  @override
  Widget build(BuildContext context) {
    Provider.of<AdminDetailsHelpers>(context,listen: false).setOrderConfirmationData(orderNo.toString());
    AdminDetailsHelpers adminDetailsHelpers = Provider.of(context, listen: false);
    adminDetailsHelpers.setOrderConfirmationData(orderNo.toString());
    bool orderCompleted = true;
    bool orderConfirmation = true;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
      adminDetailsHelpers.getOrderConfirmation == false
          ? RoundedButton(
              title: "Confirm Order",
              maxwidth: 1000,
              minwidth: 400,
              onPressed: () {
                adminDetailsHelpers.setOrderConfirmationTrue(
                    context, orderNo, orderConfirmation);
              },
            )
          : floatingActionButton(context, orderNo, orderCompleted),
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Order No " + orderNo.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderInfo(context),
            getdata(context, orderNo),
            // orderData(context, orderNo),
          ],
        ),
      ),
    );
  }

  Widget orderInfo(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 5,
            leading: Text(
              "Bill Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            minVerticalPadding: 5,
            leading: Text(
              "item Total",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: Text(
              queryDocumentSnapshot['totalNoFee'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ListTile(
            minVerticalPadding: 5,
            leading: Text(
              "Taxes and Charges",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: Text(
              queryDocumentSnapshot['fee'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ListTile(
            minVerticalPadding: 5,
            leading: Text(
              "To Pay",
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: Text(
              queryDocumentSnapshot['total'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          ListTile(
            minVerticalPadding: 5,
            leading: Text(
              "Order Status",
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Text(
              queryDocumentSnapshot['orderStatus'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getdata(BuildContext context, orderNo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 2000.0, minHeight: 200.0),
      child: FutureBuilder(
        future: Provider.of<AdminDetailsHelpers>(context, listen: false)
            .fetchDataItems(orderNo),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/foodanimation.json'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemWidget(
                  itemName: snapshot.data[index].data()['name'].toString(),
                  img: snapshot.data[index].data()['image'].toString(),
                  category: snapshot.data[index].data()['category'].toString(),
                  price: snapshot.data[index].data()['price'].toString(),
                );
              },
            );
          }
        },
      ),
    ),
  );
}

Widget getcatpage(BuildContext context, String collection, String category) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: FutureBuilder(
        future: Provider.of<AdminDetailsHelpers>(context, listen: false)
            .fetchCatData(collection, category),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/foodanimation.json'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemWidget(
                  itemName: snapshot.data[index].data()['name'],
                  img: snapshot.data[index].data()['image'],
                  category: snapshot.data[index].data()['category'],
                  price: snapshot.data[index].data()['price'].toString(),
                );
              },
            );
          }
        },
      ),
    ),
  );
}

Widget floatingActionButton(BuildContext context, orderNo, orderCompleted) {
  bool orderStatus = true;
  return FloatingActionButton(
    backgroundColor: Color(0xFFF06623),
    child: Icon(FontAwesomeIcons.check, color: Colors.white),
    onPressed: () {
      Provider.of<AdminDetailsHelpers>(context, listen: false)
          .setOrderStatus(context, orderNo, orderStatus);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              foregroundColor: Color(0xFFF06623),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Order Status ",
                style: TextStyle(color: Colors.black),
              ),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Color(0xFFF06623)),
                  onPressed: () => {
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacementNamed(AdminHomePage.routeArgs)
                      }),
            ),
            body: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "The Order is Completed",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 550,
                  child: Lottie.asset('assets/58046-check-mark.json',
                      repeat: false),
                ),
              ]),
            ),
          ),
        ),
      );
    },
  );
}
