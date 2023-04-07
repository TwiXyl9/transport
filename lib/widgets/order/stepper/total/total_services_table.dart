import 'package:flutter/material.dart';

import '../../../../models/service.dart';

class TotalServicesTable extends StatelessWidget {
  final Map<Service,int> services;
  TotalServicesTable({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: services.entries.map((entry) {
        if(entry.value > 0) {
          return TableRow(
              children: [
                Text(entry.key.name),
                Text("${entry.value}"),
                Text("${entry.key.price * entry.value} р."),
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
