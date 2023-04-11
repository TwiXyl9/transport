import 'package:flutter/material.dart';

import '../../../models/car.dart';
import '../../cars/car_item_order_view.dart';
import '../../services/service_item_view.dart';

class CarsStep extends StatelessWidget {
  final List<Car> cars;
  final int selectedCar;
  final Function carCallback;
  CarsStep({Key? key, required this.carCallback, required this.selectedCar, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 420,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: cars.map((e) => CarItemOrderView(e, carCallback, selectedCar)).toList()
          ),
        ),
      ),
    );
  }
}
