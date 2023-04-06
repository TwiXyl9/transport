import 'package:flutter/material.dart';

class TotalServicesTable extends StatelessWidget {
  final Map<int,int> services;
  TotalServicesTable({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: services.entries.map((entry) {
        return TableRow(
            children: [
              Text("${entry.key}"),
              Text("${entry.value}"),
            ]
        );
      }).toList(),
    );
  }
}
