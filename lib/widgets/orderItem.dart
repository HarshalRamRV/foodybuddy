import 'package:flutter/material.dart';
import 'package:fb_business/Models/reviewCartModal.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        leading: Image.network(
          e.image,
          width: 75.0,
          height: 75.0,
          fit: BoxFit.cover,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 250,
              child: Text(
                e.name,
                softWrap: true,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              e.quantity.toString(),
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              "\$${e.price}",
            ),
          ],
        ),
      ),
    );
  }
}
