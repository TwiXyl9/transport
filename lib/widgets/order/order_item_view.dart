import 'package:flutter/material.dart';
import 'package:transport/models/order.dart';

class OrderItemView extends StatelessWidget {
  final Order order;
  OrderItemView(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Заказ № ${order.id}", style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Цена: ${order.totalPrice} б.р", style: TextStyle(fontSize: 12),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
