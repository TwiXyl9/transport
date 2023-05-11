import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/models/car.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';
import 'package:transport/widgets/cars/car_dialog.dart';
import 'package:transport/widgets/cars/cars_item_view.dart';
import 'package:transport/widgets/components/circular_add_button.dart';
import 'package:transport/widgets/components/custom_button.dart';

import '../../widgets/components/custom_circular_progress_indicator.dart';
import '../../widgets/order/order_button.dart';
class CarsView extends StatelessWidget {
  CarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
        builder: (context, state) {
        print(state);
        if (state is CarsLoadedState){
          void openCarDialog(){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CarDialog(new Car(0), state.tailTypes);
                }
            );
          }
          return Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Column(
                children: [
                  Text("Наш Автопарк"),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minWidth: 300, maxWidth: 800),
                      child: GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          children: state.cars.map((e) => CarsItemView(e, state.user.isAdmin(), state.tailTypes)).toList()
                      ),
                    ),
                  ),
                ],
              ),
              !state.user.isAdmin() ?
              OrderButton(context) :
              CircularAddButton(openCarDialog),
            ]
          );
       }
      return Center(
        child: CustomCircularProgressIndicator(),
      );
    });
  }
}
