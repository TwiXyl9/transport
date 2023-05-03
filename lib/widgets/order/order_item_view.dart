import 'package:flutter/material.dart';
import 'package:transport/models/order.dart';

import '../components/bold_text.dart';

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
                BoldText("Заказ № ${order.id}"),
                Row(children: [
                  Text("Машина: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  Text("${order.car.brand} ${order.car.model}", style: TextStyle(fontSize: 12),),
                ],),
                Row(children: [
                  Text("Дата и время: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  Text("${order.dateTime}", style: TextStyle(fontSize: 12),),
                ],),
                Row(children: [
                  Text("Стоимость: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  Text("${order.totalPrice} б.р", style: TextStyle(fontSize: 12),),
                ],),
              ],
            ),
            Text("Статус: ${order.stage}", style: TextStyle(fontSize: 12),),
          ],
        ),
      ),
    );
  }
}
