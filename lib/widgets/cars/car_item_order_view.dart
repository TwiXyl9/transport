import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';
import 'package:transport/widgets/cars/car_info_view.dart';

class CarItemOrderView extends StatelessWidget {
  final Car car;
  Function selectCallback;
  Car selectedCar;
  CarItemOrderView(this.car, this.selectCallback, this.selectedCar);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        selectedCar = car;
        selectCallback(selectedCar);
      },
      child: Container(
        decoration: selectedCar == car? BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 20.0,
              offset: Offset(3,5)
            ),
          ],
        ) : BoxDecoration(),
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
                  child: Image.network(car.imagesUrls[0]),
                ),
                CarInfoView(car),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
