import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/components/custom_circular_progress_indicator.dart';
import 'package:transport/widgets/order/order_list_view.dart';

import '../../blocs/order_bloc.dart';

class AdminOrdersView extends StatelessWidget {
  const AdminOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          print(state);
          if (state is OrderLoadedState) {
            return OrderListView(state.orders, state.user.isAdmin());
          }
          return CustomCircularProgressIndicator();
        },
      ),
    );
  }
}
