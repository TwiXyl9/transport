import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transport/models/car.dart';

class CarImageSliderView extends StatelessWidget {
  final Car car;
  const CarImageSliderView(this.car);

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: car.imagesUrls.length > 1 ?
      CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 0.5
        ),
        carouselController: carouselController,
        items: car.imagesUrls.map((img) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Image.network(img),
              );
            },
          );
        }).toList(),
      ) :
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Image.network(car.imagesUrls.first),
      ),
    );
  }
}
