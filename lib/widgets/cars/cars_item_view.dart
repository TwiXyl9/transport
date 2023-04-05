import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transport/models/car.dart';
import 'package:transport/widgets/cars/car_image_slider_view.dart';
import 'package:transport/widgets/cars/car_info_view.dart';

class CarsItemView extends StatelessWidget {
  final Car car;
  CarsItemView(this.car);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Column(
        children: [
          CarImageSliderView(car),
          CarInfoView(car),
        ],
      ),
    );

  }
}
