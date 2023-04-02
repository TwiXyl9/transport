import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transport/models/car.dart';

class CarsItemView extends StatefulWidget {
  final Car car;
  int groupValue;
  Function radioCallback;
  CarsItemView(this.car, this.radioCallback, [this.groupValue = -1]);

  @override
  State<CarsItemView> createState() => _CarsItemViewState();
}

class _CarsItemViewState extends State<CarsItemView> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Card(
      elevation: 12,
      child: Column(
        children: [
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.5
                    ),
                    carouselController: carouselController,
                    items: widget.car.images.map((img) {
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
                  deviceType != DeviceScreenType.mobile ?
                  Container(
                    child: Stack(
                      children: [
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
                      ],
                    ),
                  ) : Container()
                ],
              ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText('${widget.car.brand}\n${widget.car.model}', maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8,),
                AutoSizeText('Характеристики кузова:\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                AutoSizeText('Грузоподъемность до: ${widget.car.loadCapacity} т.\n'
                    'Ширина: ${widget.car.width}\n'
                    'Высота: ${widget.car.height}\n'
                    'Длина: ${widget.car.length}\n'
                    'Кол-во европаллет: ${widget.car.numOfPallets}\n'
                    'Тип борта: ${widget.car.tailType}',
                  textAlign: TextAlign.start
                ),
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
        ],
      ),
    );

  }
}
