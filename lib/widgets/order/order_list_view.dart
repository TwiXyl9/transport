import 'package:flutter/material.dart';
import 'package:transport/widgets/order/order_item_view.dart';

import '../../models/order.dart';

class OrderListView extends StatelessWidget {
  final List<Order> orders;
  final bool isAdmin;
  OrderListView(this.orders, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        children: orders.map((e) => OrderItemView(e, isAdmin)).toList(),
      ),
    );
  }
}
