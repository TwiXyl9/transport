import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/widgets/cars/car_info_view.dart';

class CarItemOrderView extends StatefulWidget {
  final Car car;
  Function radioCallback;
  int groupValue;
  CarItemOrderView(this.car, this.radioCallback,[this.groupValue = -1]);

  @override
  State<CarItemOrderView> createState() => _CarItemOrderViewState();
}

class _CarItemOrderViewState extends State<CarItemOrderView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
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
            widget.groupValue != -1?
            Radio(
                value: widget.car.id,
                groupValue: widget.groupValue,
                onChanged: (val)=>{
                  setState(() {
                    widget.radioCallback(val);
                  })
                }
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
