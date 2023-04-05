import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/widgets/cars/car_info_view.dart';

class CarItemOrderView extends StatefulWidget {
  final Car car;
  Function selectCallback;
  int groupValue;
  CarItemOrderView(this.car, this.selectCallback, this.groupValue);

  @override
  State<CarItemOrderView> createState() => _CarItemOrderViewState();
}

class _CarItemOrderViewState extends State<CarItemOrderView> {
  late Car _car;
  late Function _selectCallback;
  late int _groupValue;
  void initState() {
    _car = widget.car;
    _selectCallback = widget.selectCallback;
    _groupValue = widget.groupValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          _groupValue = _car.id;
          _selectCallback(_groupValue);
        });

      },
      child: Container(
        decoration: widget.groupValue == _car.id? BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.green,
              blurRadius: 20.0,
              offset: Offset(3,5)
            ),
          ],
        ):BoxDecoration(),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Image.network(widget.car.images[0]),
                ),
                CarInfoView(widget.car),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
