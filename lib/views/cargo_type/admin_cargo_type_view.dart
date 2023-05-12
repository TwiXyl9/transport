import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/cargo_type_bloc.dart';
import 'package:transport/widgets/components/custom_circular_progress_indicator.dart';

import '../../widgets/cargo_type/cargo_type_list_view.dart';

class AdminCargoTypeView extends StatelessWidget {
  const AdminCargoTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CargoTypeBloc, CargoTypeState>(
      builder: (context, state) {
        return state is CargoTypeLoadedState?
        Center(
          child: Container(
            constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
            child: SingleChildScrollView(
                child: CargoTypeListView(state.types)
            ),
          ),
        ) :
        CustomCircularProgressIndicator();
      },
    );
  }
}
