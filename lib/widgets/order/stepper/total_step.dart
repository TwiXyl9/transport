import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/widgets/order/stepper/total_services_table.dart';

class TotalStep extends StatelessWidget {
  final String name;
  final String phone;
  final String dateTime;
  final Car car;
  Map<int,int> servicesCount;
  TotalStep({Key? key, required this.name, required this.phone, required this.dateTime, required this.car, required this.servicesCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                Text("Имя:"),
                Text(name),
              ]
            ),
            TableRow(
                children: [
                  Text("Телефон:"),
                  Text(phone),
                ]
            ),
            TableRow(
                children: [
                  Text("Дата и время:"),
                  Text(dateTime),
                ]
            ),
            TableRow(
                children: [
                  Text("Машина:"),
                  Text("${car.brand} ${car.model}"),
                ]
            ),
          ],
        ),
        TotalServicesTable(services: servicesCount)
      ],
    );
  }
}
