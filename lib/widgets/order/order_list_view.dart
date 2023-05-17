import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:transport/widgets/components/dropdown_sorting_view.dart';
import 'package:transport/widgets/filter/filter_button_view.dart';
import 'package:transport/widgets/order/order_item_view.dart';

import '../../models/order.dart';
import '../filter/filter_dialog.dart';

class OrderListView extends StatefulWidget {
  final List<Order> orders;
  final bool isAdmin;
  OrderListView(this.orders, this.isAdmin);

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  var selectedSort = "По новизне";
  List<String> selectedStages = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
            child: DropdownSortingView(ordersSorting, selectedSort)
        ),
        Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: widget.orders.map((e) => OrderItemView(e, widget.isAdmin)).toList(),
            ),
          ),
        ),
        FilterButtonView(openFilterDialog)
      ],
    );
  }
  void ordersSorting(val){
    setState(() {
      selectedSort = val;
      if (val == "По дате выполнения") widget.orders.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      if (val == "По цене") widget.orders.sort((a, b) => a.totalPrice.compareTo(b.totalPrice));
      if (val == "По новизне") widget.orders.sort((a, b) => a.created_at.compareTo(b.created_at));
    });
  }
  void openFilterDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterDialog(selectedStages, stagesCallback);
        }
    );
  }
  void stagesCallback(stages){
    selectedStages = stages;
    print(selectedStages);
  }
}
