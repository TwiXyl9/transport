import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/additional_service_bloc.dart';
import '../../widgets/additional_service/additional_service_list_view.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';

class AdditionalServiceView extends StatelessWidget {
  const AdditionalServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalServiceBloc, AdditionalServiceState>(
      builder: (context, state) {
        print(state);
        return state is AdditionalServiceLoadedState?
        Center(
          child: Container(
            constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
            child: SingleChildScrollView(
                child: AdditionalServiceListView(state.services, state.user)
            ),
          ),
        ) :
        CustomCircularProgressIndicator();
      },
    );
  }
}
