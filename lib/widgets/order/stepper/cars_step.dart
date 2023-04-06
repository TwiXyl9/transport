import 'package:flutter/material.dart';

import '../../../models/car.dart';
import '../../cars/car_item_order_view.dart';
import '../../services/service_item_view.dart';

class CarsStep extends StatefulWidget {
  final List<Car> cars;
  CarsStep({Key? key, required this.cars}) : super(key: key);

  @override
  State<CarsStep> createState() => _CarsStepState();
}


class _CarsStepState extends State<CarsStep> {
  late List<Car> _cars;
  int groupValue = -1;
  @override
  void initState() {
    _cars = widget.cars;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 420,
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: _cars.map((e) => CarItemOrderView(e, callBack, groupValue)).toList()
        ),
      ),
    );
  }
  callBack(val) {
    setState(() {
      groupValue = val;
    });
  }
}
