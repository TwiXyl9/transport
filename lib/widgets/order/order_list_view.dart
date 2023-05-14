import 'package:flutter/material.dart';
import 'package:transport/widgets/components/dropdown_sorting_view.dart';
import 'package:transport/widgets/order/order_item_view.dart';

import '../../models/order.dart';

class OrderListView extends StatefulWidget {
  final List<Order> orders;
  final bool isAdmin;
  OrderListView(this.orders, this.isAdmin);

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  var selectedSort = "По новизне";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSortingView(ordersSorting, selectedSort),
        SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: widget.orders.map((e) => OrderItemView(e, widget.isAdmin)).toList(),
          ),
        ),
      ],
    );
  }
  void ordersSorting(val){
    setState(() {
      selectedSort = val;
      if (val == "По дате выполнения") widget.orders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      if (val == "По новизне") widget.orders.sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
    });
  }
}
