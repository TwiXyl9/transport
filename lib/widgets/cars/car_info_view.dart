import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transport/models/car.dart';

class CarInfoView extends StatelessWidget {
  final Car car;

  CarInfoView(this.car);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText('${car.brand}\n${car.model}', maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8,),
          AutoSizeText('Характеристики кузова:\n',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          AutoSizeText(
              'Грузоподъемность до: ${car.loadCapacity} т.\n'
              'Ширина: ${car.width}\n'
              'Высота: ${car.height}\n'
              'Длина: ${car.length}\n'
              'Кол-во европаллет: ${car.numOfPallets}\n'
              'Тип борта: ${car.tailType}\n'
              'Цена за час: ${car.price} р.',
              textAlign: TextAlign.start
          ),
        ],
      ),
    );
  }
}
