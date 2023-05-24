import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/order/order_button.dart';

import '../../blocs/additional_service_bloc.dart';
import '../../models/service.dart';
import '../../widgets/additional_service/additional_service_dialog.dart';
import '../../widgets/additional_service/additional_service_list_view.dart';
import '../../widgets/components/circular_add_button.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';

class AdditionalServiceView extends StatelessWidget {
  const AdditionalServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalServiceBloc, AdditionalServiceState>(
      builder: (context, state) {
        print(state);
        return state is AdditionalServiceLoadedState?
        Stack(
          alignment: Alignment.center,
          children: [
            state.services.length > 0 ?
            CenteredView(
              child: AdditionalServiceListView(state.services, state.user),
            ) :
            Center(child: Text('У компании пока нет услуг! Создайте первую!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
            state.user.isAdmin() ?
            CircularAddButton(() => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdditionalServiceDialog(new Service(0));
                }
            )) :
            OrderButton(context),
          ],
        ) :
        CustomCircularProgressIndicator();
      },
    );
  }
}
