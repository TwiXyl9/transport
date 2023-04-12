import 'package:flutter/material.dart';
import 'package:transport/widgets/order/order_item_view.dart';

import '../../models/order.dart';

class OrderListView extends StatelessWidget {
  final List<Order> orders;
  OrderListView(this.orders);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: orders.map((e) => OrderItemView(e)).toList(),
        ),
      ],
    );
  }
}
