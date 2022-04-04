import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/Views/paymentSummary/orderItem.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStatus extends StatelessWidget {
  final int orderNo;
  OrderStatus({required this.orderNo});
  Future<void> dialNumber({required BuildContext context}) async {
    final url = "tel:9790134571";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to call 1234567890")));
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<OrderProvider>(context, listen: false).getOrderNo(context,orderNo.toString());
    // Provider.of<OrderProvider>(context, listen: false).getOrderSat();
    Provider.of<PaymentHelper>(context, listen: false).setOrderNumber();
    OrderProvider orderProvider = Provider.of(context);
    orderProvider.getOrderData(orderNo.toString());
    orderProvider.setOrderStatus(orderNo.toString());
    orderProvider.setFee(orderNo.toString());
    orderProvider.setTotalNoFee(orderNo.toString());
    double totalPrice = orderProvider.getTotalPrice();
    return Scaffold(
      bottomNavigationBar: ListTile(
          title: RoundedButton(
              title: "Contact FoodyBuddy",
              onPressed: () {
                dialNumber(context: context);
              },
              maxwidth: 300,
              minwidth: 250)),
      appBar: AppBar(
        foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Order No #$orderNo",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: orderProvider.getOrdersDataList.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      orderProvider.getOrderStatus == false
                          ? Center(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Your Order is getting ready...",
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                                                    width:
                                      MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 450,
                                  child: Lottie.asset(
                                      'assets/13679-fast-food-mobile-app-loading.json',),
                                ),
                              ]),
                            )
                          : Center(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Your Order is Ready",
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                                                    width:
                                      MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 550,
                                  child: Lottie.asset(
                                      'assets/58046-check-mark.json',
                                      repeat: false),
                                ),
                              ]),
                            ),
                      ExpansionTile(
                        textColor: Color(0xFFF06623),
                        iconColor: Color(0xFFF06623),
                        children: orderProvider.getOrdersDataList.map((e) {
                          return OrderItem(
                            e: e,
                          );
                        }).toList(),
                        title: Text(
                            "Order Items ${orderProvider.getOrdersDataList.length}"),
                      ),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "Bill Details",
                          style: TextStyle(
                            fontSize: 16,
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
                          orderProvider.getTotalNoFee.toString(),
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
                          orderProvider.getFee.toString(),
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
                          (orderProvider.getFee+orderProvider.getTotalNoFee).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   minVerticalPadding: 5,
                      //   leading: Text(
                      //     "Order Status",
                      //     style: TextStyle(color: Colors.grey[600]),
                      //   ),
                      //   trailing: Text(
                      //     orderProvider.getOrderStatus == false
                      //         ? "Your Order is getting ready"
                      //         : "Your order is ready",
                      //     softWrap: true,
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ]);
                  })),
    );
  }
}
