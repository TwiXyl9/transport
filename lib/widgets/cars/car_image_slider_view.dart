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
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 0.5
            ),
            carouselController: carouselController,
            items: car.images.map((img) {
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
          ),
          if (deviceType != DeviceScreenType.mobile) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  onPressed: () {
                    carouselController.previousPage();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  onPressed: () {
                    carouselController.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ] else Container()
        ],
      ),
    );
  }
}
