import 'package:flutter/material.dart';
import 'package:transport/models/order_service.dart';

import '../../../../models/service.dart';

class TotalServicesTable extends StatelessWidget {
  final List<OrderService> services;
  TotalServicesTable({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: services.map((e) {
        if(e.amount > 0) {
          return TableRow(
              children: [
                Text(e.service.name),
                Text("${e.service.price} р. x ${e.amount}"),
                Text("${e.service.price * e.amount} р."),
              ]
          );
        } else {
          return TableRow(
              children: [
                Container(),
                Container(),
                Container(),
              ]
          );
        }
      }).toList(),
    );
  }
}
