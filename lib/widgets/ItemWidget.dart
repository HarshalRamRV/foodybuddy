import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/widgets/count.dart';

class ItemWidget extends StatelessWidget {
  final itemName;
  final img;
  final category;
  final price;
  ItemWidget(
      {@required this.itemName,
      required this.img,
      required this.category,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, spreadRadius: 2.0, blurRadius: 5.0),
          ]),
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                child: SizedBox(
                  child: Image.network(
                    img,
                    width: 125.0,
                    height: 125.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            //         mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 145,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        itemName,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        category,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.rupeeSign,
                            size: 18.0,
                          ),
                          Text(
                            price,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Count(
                          productName: itemName,
                          productImage: img,
                          productPrice: int.parse(price),
                          productCategory: category,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
