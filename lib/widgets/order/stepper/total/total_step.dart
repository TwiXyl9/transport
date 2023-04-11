import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/cargo_type.dart';
import 'package:transport/widgets/order/stepper/total/total_price_table.dart';
import 'package:transport/widgets/order/stepper/total/total_services_table.dart';

import '../../../../models/service.dart';
import '../../../components/bold_text.dart';

class TotalStep extends StatelessWidget {
  final String name;
  final String phone;
  final String dateTime;
  final Car car;
  final CargoType cargoType;
  Map<Service,int> servicesCount;
  TotalStep({Key? key, required this.name, required this.phone, required this.dateTime, required this.car, required this.cargoType, required this.servicesCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                BoldText(text: "Имя:"),
                Text(name),
                Container()
              ]
            ),
            TableRow(
                children: [
                  BoldText(text: "Телефон:"),
                  Text(phone),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText(text: "Дата и время:"),
                  Text(dateTime),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText(text: "Тип груза:"),
                  Text(cargoType.name),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText(text: "Машина:"),
                  Text("${car.brand} ${car.model}"),
                  Text("${car.price} р."),
                ]
            ),
            TableRow(
                children: [
                  BoldText(text: "Услуги:"),
                  Container(),
                  Container()
                ]
            ),
          ],
        ),
        TotalServicesTable(services: servicesCount),
        TotalPriceTable(price: getTotalPrice()),
      ],
    );
  }
  double getTotalPrice(){
    double result = car.price;
    servicesCount.forEach((key, value) {
      result += key.price * value;
    });
    return result;
  }
}
