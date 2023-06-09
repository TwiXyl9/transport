import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
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
class CarsView extends StatefulWidget {
  CarsView({Key? key}) : super(key: key);

  @override
  State<CarsView> createState() => _CarsViewState();
}

class _CarsViewState extends State<CarsView> {
  int _counter = 1;
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
                state.user.isAdmin() ?
                CircularAddButton(() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CarDialog(new Car(0), state.tailTypes);
                    }
                )) :
                Container(),
                ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: state.carsPagination.cars.map((e) => CarsItemView(e, state.user.isAdmin(), state.tailTypes)).toList()
                ),
                WebPagination(
                    currentPage: _counter,
                    totalPage: state.carsPagination.count,
                    displayItemCount: 5,
                    onPageChanged: (page) {
                      setState(() {
                        _counter = page;
                        context.read<CarsBloc>().add(InitialCarsEvent(page: _counter));
                      });
                    }),
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
