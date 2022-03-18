import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:foodybuddy/Views/paymentSummary/orderItem.dart';
import 'package:foodybuddy/Views/paymentSummary/paymesntSummary.dart';
import 'package:foodybuddy/widgets/ItemWidget.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class OrderStatus extends StatelessWidget {
  
  final int orderNo;
  OrderStatus({required this.orderNo});
  @override
  Widget build(BuildContext context) {
    // Provider.of<OrderProvider>(context, listen: false).getOrderNo(context,orderNo.toString());
    // Provider.of<OrderProvider>(context, listen: false).getOrderSat();
    Provider.of<PaymentHelper>(context, listen: false).getOrderNumber();
    OrderProvider orderProvider = Provider.of(context);
    orderProvider.getOrderData(orderNo.toString());
    orderProvider.setOrderStatus(orderNo.toString());
    double totalPrice = orderProvider.getTotalPrice();
    return Scaffold(
      bottomNavigationBar: ListTile(
          title: Text("Total Aount"),
          subtitle: Text(
            "\$ ${orderProvider.getTotalPrice()}",
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          trailing: RoundedButton(
              title: "Contact FoodyBuddy",
              onPressed: () {},
              maxwidth: 300,
              minwidth: 250)),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "ORDER STATUS",
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
                      Divider(),
                      ExpansionTile(
                        children: orderProvider.getOrdersDataList.map((e) {
                          return OrderItem(
                            e: e,
                          );
                        }).toList(),
                        title: Text(
                            "Order Items ${orderProvider.getOrdersDataList.length}"),
                      ),
                      Divider(),
                      ListTile(
                        minVerticalPadding: 5,
                        leading: Text(
                          "Sub Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "\$${totalPrice + 5}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
                          orderProvider.getOrderStatus.toString(),
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
