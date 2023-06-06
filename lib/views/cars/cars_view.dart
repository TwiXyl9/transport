import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/cars_bloc.dart';
import 'package:transport/models/car.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';
import 'package:transport/widgets/cars/car_dialog.dart';
import 'package:transport/widgets/cars/cars_item_view.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/components/circular_add_button.dart';
import 'package:transport/widgets/components/custom_button.dart';

import '../../widgets/components/custom_circular_progress_indicator.dart';
import '../../widgets/components/page_header_text.dart';
import '../../widgets/order/order_button.dart';
import '../layout_template/layout_template.dart';
class CarsView extends StatelessWidget {
  CarsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      child: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
          print(state);
          if (state is CarsLoadedState){
            return Column(
              children: [
                PageHeaderText(text: "Наш автопарк"),
                ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: state.cars.map((e) => CarsItemView(e, state.user.isAdmin(), state.tailTypes)).toList()
                ),
                state.user.isAdmin() ?
                CircularAddButton(() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CarDialog(new Car(0), state.tailTypes);
                    }
                )) :
                Container(),
              ],
            );
         }
        return Center(
          child: CustomCircularProgressIndicator(),
        );
      }),
    );
  }
}
