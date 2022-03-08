import 'package:flutter/material.dart';
import 'package:foodybuddy/Models/reviewCartModal.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.image,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
           e.name,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            e.category,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "\$${e.price}",
            
          ),
        ],
      ),
      subtitle: Text(e.quantity.toString()),
    );
  }
}