import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/tail_type.dart';
import 'package:transport/widgets/cars/car_dialog.dart';
import 'package:transport/widgets/cars/car_image_slider_view.dart';
import 'package:transport/widgets/cars/car_info_view.dart';
import 'package:transport/widgets/error/error_dialog_view.dart';

import '../components/custom_button.dart';

class CarsItemView extends StatelessWidget {
  final Car car;
  final bool isAdmin;
  final List<TailType> tailTypes;
  CarsItemView(this.car, this.isAdmin, this.tailTypes);

  @override
  Widget build(BuildContext context) {

    void deleteCar(){
      final bloc = Provider.of<CarsBloc>(context, listen: false);
      try {
        bloc.add(DeleteCarEvent(car));
        bloc.add(InitialCarsEvent(1));
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }

    return Card(
      elevation: 12,
      child: Column(
        children: [
          CarImageSliderView(car),
          CarInfoView(car),
          if (isAdmin) ...[
            CustomButton(
                btnText: "Редактировать",
                onTap:() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CarDialog(car, tailTypes);
                    }
                ),
                btnColor: Colors.blue
            ),
            CustomButton(btnText: "Удалить", onTap:() => {deleteCar()} , btnColor: Colors.red),
          ]

        ],
      ),
    );

  }
}
