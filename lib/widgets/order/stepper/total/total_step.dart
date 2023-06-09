import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/cargo_type.dart';
import 'package:transport/models/order_service.dart';
import 'package:transport/widgets/order/stepper/total/total_price_table.dart';
import 'package:transport/widgets/order/stepper/total/total_services_table.dart';
import '../../../components/bold_text.dart';
import 'package:google_maps_webservice/places.dart';

class TotalStep extends StatelessWidget {
  final String name;
  final String phone;
  final String dateTime;
  final PlaceDetails departure;
  final PlaceDetails arrival;
  final double totalPrice;
  final Car car;
  final CargoType cargoType;
  List<OrderService> services;
  TotalStep({
    Key? key,
    required this.name,
    required this.phone,
    required this.dateTime,
    required this.departure,
    required this.arrival,
    required this.totalPrice,
    required this.car,
    required this.cargoType,
    required this.services
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                BoldText("Имя:"),
                Text(name),
                Container()
              ]
            ),
            TableRow(
                children: [
                  BoldText("Телефон:"),
                  Text(phone),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText("Дата и время:"),
                  Text(dateTime),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText("Точка погрузки:"),
                  Text(departure.formattedAddress != null? departure.formattedAddress! : ""),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText("Точка выгрузки:"),
                  Text(arrival.formattedAddress != null? arrival.formattedAddress! : ""),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText("Тип груза:"),
                  Text(cargoType.name),
                  Container()
                ]
            ),
            TableRow(
                children: [
                  BoldText("Машина:"),
                  Text("${car.brand} ${car.model}"),
                  Text("${car.pricePerHour} р."),
                ]
            ),
            if (services.length > 0)
              TableRow(
                children: [
                  BoldText("Услуги:"),
                  Container(),
                  Container()
                ]
            ),
          ],
        ),
        TotalServicesTable(services: services),
        TotalPriceTable(price: totalPrice),
      ],
    );
  }
}
