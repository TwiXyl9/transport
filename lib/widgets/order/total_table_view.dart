import 'package:flutter/material.dart';
import 'package:transport/widgets/order/stepper/total/total_price_table.dart';
import 'package:transport/widgets/order/stepper/total/total_services_table.dart';

import '../../models/car.dart';
import '../../models/order_service.dart';
import '../components/bold_text.dart';

class TotalTableView extends StatelessWidget {
  final Car car;
  List<OrderService> services;
  final double totalPrice;
  TotalTableView(this.car, this.services, this.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
                children: [
                  BoldText("Машина:"),
                  Text("${car.brand} ${car.model}"),
                  Text("${car.price} р."),
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
