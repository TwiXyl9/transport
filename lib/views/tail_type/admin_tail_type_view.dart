import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/tail_type_bloc.dart';
import '../../widgets/cargo_type/cargo_type_list_view.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';
import '../../widgets/tail_type/tail_type_list_view.dart';

class AdminTailTypeView extends StatelessWidget {
  const AdminTailTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TailTypeBloc, TailTypeState>(
      builder: (context, state) {
        return state is TailTypeLoadedState?
        Center(
          child: Container(
            constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
            child: SingleChildScrollView(
                child: TailTypeListView(state.types)
            ),
          ),
        ) :
        CustomCircularProgressIndicator();
      },
    );
  }
}
