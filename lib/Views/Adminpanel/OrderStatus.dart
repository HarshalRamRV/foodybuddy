import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fb_business/Providers/orderProvider.dart';
import 'package:fb_business/Services/AdminDetailsHelpers.dart';
import 'package:fb_business/Views/Adminpanel/AdminHomepage.dart';
import 'package:fb_business/Views/Mainpage.dart';
import 'package:fb_business/widgets/ItemWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderStatus extends StatefulWidget {
  final String orderNo;
  final QueryDocumentSnapshot queryDocumentSnapshot;
  OrderStatus({required this.orderNo, required this.queryDocumentSnapshot});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    AdminDetailsHelpers adminDetailsHelpers =
        Provider.of(context, listen: false);
    OrderProvider orderProvider = Provider.of(context, listen: false);
    orderProvider.getOrderData(widget.orderNo.toString());
    orderProvider.setOrderStatus(widget.orderNo.toString());
    adminDetailsHelpers.setOrderConfirmationData(widget.orderNo.toString());
    orderProvider.setFee(widget.orderNo.toString());
    orderProvider.setTotalNoFee(widget.orderNo.toString());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(context, widget.orderNo),
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Color(0xFFF06623)),
            onPressed: () => {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed(Mainscreen.routeArgs)
                }),
        backgroundColor: Colors.white,
        title: Text(
          "Order No ${widget.orderNo}",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderInfo(context, widget.queryDocumentSnapshot),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 2000.0, minHeight: 200.0),
                child: FutureBuilder(
                  future:
                      Provider.of<AdminDetailsHelpers>(context, listen: false)
                          .fetchDataItems(widget.orderNo),
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

Widget floatingActionButton(BuildContext context, orderNo) {
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
                            .pushReplacementNamed(Mainscreen.routeArgs)
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
