import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/order/order_button.dart';

import '../../blocs/additional_service_bloc.dart';
import '../../models/service.dart';
import '../../widgets/additional_service/additional_service_dialog.dart';
import '../../widgets/additional_service/additional_service_list_view.dart';
import '../../widgets/components/circular_add_button.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';
import '../../widgets/components/page_header_text.dart';

class AdditionalServiceView extends StatefulWidget {
  const AdditionalServiceView({Key? key}) : super(key: key);

  @override
  State<AdditionalServiceView> createState() => _AdditionalServiceViewState();
}

class _AdditionalServiceViewState extends State<AdditionalServiceView> {
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      child: BlocBuilder<AdditionalServiceBloc, AdditionalServiceState>(
        builder: (context, state) {
          print(state);
          return state is AdditionalServiceLoadedState?
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                PageHeaderText(text: "Дополнительные услуги"),
                state.user.isAdmin() ?
                CircularAddButton(() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdditionalServiceDialog(new Service(0));
                    }
                )) :
                Container(),
                state.servicesPagination.services.length > 0 ?
                Column(
                  children: [
                    AdditionalServiceListView(state.servicesPagination.services, state.user),
                    state.servicesPagination.count > 1 ?
                    WebPagination(
                        currentPage: _counter,
                        totalPage: state.servicesPagination.count,
                        displayItemCount: 5,
                        onPageChanged: (page) {
                          setState(() {
                            _counter = page;
                            context.read<AdditionalServiceBloc>().add(InitialAdditionalServiceEvent(page: _counter));
                          });
                        }) :
                    Container(),
                  ],
                ) :
                Center(
                    child: Text(
                      'У компании пока нет услуг! Создайте первую!',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ],
            ),
          ) :
          CustomCircularProgressIndicator();
        },
      ),
    );
  }
}
