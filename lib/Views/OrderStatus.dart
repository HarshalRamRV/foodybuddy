import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/Views/paymentSummary/orderItem.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStatus extends StatelessWidget {
  final int orderNo;
  OrderStatus({required this.orderNo});
  Future<void> dialNumber({required BuildContext context}) async {
    final url = "tel:1234567890";
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
    Provider.of<PaymentHelper>(context, listen: false).getOrderNumber();
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
                      ExpansionTile(
                        initiallyExpanded: true,
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
                          totalPrice.toString(),
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
                          orderProvider.getOrderStatus == false
                              ? "Your Order is getting ready"
                              : "Your order is ready",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]);
                  })),
    );
  }
}
