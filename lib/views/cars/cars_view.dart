import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/models/car.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';
import 'package:transport/widgets/cars/cars_item_view.dart';

import '../../widgets/order/order_button.dart';
class CarsView extends StatelessWidget {
  CarsView({Key? key}) : super(key: key);
  ApiService api = ApiService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(builder: (context, state) {
      if (state is CarsInitial){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CarsLoaded){
        return Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Column(
              children: [
                Text("Наш Автопарк"),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 300, maxWidth: 800),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 1,
                        shrinkWrap: true,
                        children: state.cars.map((e) => CarsItemView(e)).toList()
                    ),
                  ),
                ),
              ],
            ),
            OrderButton(context),
          ]
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
