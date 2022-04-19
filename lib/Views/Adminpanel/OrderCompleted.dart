import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/Services/AdminDetailsHelpers.dart';
import 'package:foodybuddy/Views/Adminpanel/AdminHomepage.dart';
import 'package:foodybuddy/Views/Adminpanel/OrderStatus.dart';
import 'package:foodybuddy/widgets/ItemWidget.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderCompleted extends StatelessWidget {
  final String orderNo;
  final QueryDocumentSnapshot queryDocumentSnapshot;
  OrderCompleted({required this.orderNo, required this.queryDocumentSnapshot});

  @override
  Widget build(BuildContext context) {
    AdminDetailsHelpers adminDetailsHelpers =
        Provider.of(context, listen: false);
    OrderProvider orderProvider = Provider.of(context, listen: false);
    orderProvider.getOrderData(orderNo.toString());
    orderProvider.setOrderStatus(orderNo.toString());
    adminDetailsHelpers.setOrderConfirmationData(orderNo.toString());
    orderProvider.setFee(orderNo.toString());
    orderProvider.setTotalNoFee(orderNo.toString());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          floatingActionButton(context, orderNo, queryDocumentSnapshot),
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Order No ${orderNo}",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderInfo(context, queryDocumentSnapshot),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 2000.0, minHeight: 200.0),
                child: FutureBuilder(
                  future:
                      Provider.of<AdminDetailsHelpers>(context, listen: false)
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
                            itemName:
                                snapshot.data[index].data()['name'].toString(),
                            img:
                                snapshot.data[index].data()['image'].toString(),
                            category: snapshot.data[index]
                                .data()['category']
                                .toString(),
                            price:
                                snapshot.data[index].data()['price'].toString(),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
            // orderData(context, orderNo),
          ],
        ),
      ),
    );
  }
}

Widget orderInfo(BuildContext context, queryDocumentSnapshot) {
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

Widget floatingActionButton(
    BuildContext context, orderNo, queryDocumentSnapshot) {
  AdminDetailsHelpers adminDetailsHelpers = Provider.of(context, listen: false);
  bool orderConfirmation = true;

  return RoundedButton(
    title: "Confirm Order",
    maxwidth: 1000,
    minwidth: 400,
    onPressed: () {
      adminDetailsHelpers
          .setOrderConfirmationTrue(context, orderNo, orderConfirmation)
          .whenComplete(() => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderStatus(
                      orderNo:
                          (queryDocumentSnapshot.data() as dynamic)['orderNo']
                              .toString(),
                      queryDocumentSnapshot: queryDocumentSnapshot,
                    ),
                  ),
                )
            }
          );
    },
  );
}
