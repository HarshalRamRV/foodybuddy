import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/widgets/orderItem.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderStatus extends StatelessWidget {
  final String orderNo;
  OrderStatus({required this.orderNo});

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of(context);
    orderProvider.getOrderData(orderNo.toString());
    orderProvider.setOrderStatus(orderNo.toString());
    orderProvider.setOrderConfirmation(orderNo.toString());
    orderProvider.setFee(orderNo.toString());
    orderProvider.setTotalNoFee(orderNo.toString());
    return Scaffold(
      bottomNavigationBar: ListTile(
          title: RoundedButton(
              title: "Contact FoodyBuddy",
              onPressed: () {
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
      body:Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      orderProvider.getOrderConfirmation == false ?  Center(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Confirmating Your Order",
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Lottie.asset(
                                        'assets/99603-yellow-dots-flicker.json',
                                        ),
                                  ),
                                ),
                              ]),
                            ): Center(
                      child: orderProvider.getOrderStatus == false
                          ? Column(children: [
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
                                      MediaQuery.of(context).size.height - 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Lottie.asset(
                                        'assets/21421-waiting.json',),
                                  ),
                                ),
                              ])
                            
                          : Column(children: [
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
                      ),
                    ]);
                  })),
    );
  }
}
