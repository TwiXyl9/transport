import 'package:flutter/material.dart';

class TotalPriceTable extends StatelessWidget {
  final double price;
  TotalPriceTable({Key? key,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Container(),
            Container(),
           Divider(
             thickness: 0.5,
             color: Colors.grey[400],
           )
          ]
        ),
        TableRow(
            children: [
              Text("Стоимость: "),
              Container(),
              Text("${price} р."),
            ]
        ),
      ],
    );
  }
}
