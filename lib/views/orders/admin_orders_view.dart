import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/components/custom_circular_progress_indicator.dart';
import 'package:transport/widgets/components/page_header_text.dart';
import 'package:transport/widgets/order/order_list_view.dart';

import '../../blocs/order_bloc.dart';

class AdminOrdersView extends StatefulWidget {
  const AdminOrdersView({Key? key}) : super(key: key);

  @override
  State<AdminOrdersView> createState() => _AdminOrdersViewState();
}

class _AdminOrdersViewState extends State<AdminOrdersView> {
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    return LayoutTemplate(
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          print(state);
          if (state is OrderLoadedState) {
            return state.ordersPagination.orders.length > 0 ?
            Column(
              children: [
                OrderListView(state.ordersPagination.orders, state.user.isAdmin()),
                state.ordersPagination.count > 1 ?
                WebPagination(
                    currentPage: _counter,
                    totalPage: state.ordersPagination.count,
                    displayItemCount: 5,
                    onPageChanged: (page) {
                      setState(() {
                        _counter = page;
                        context.read<OrderBloc>().add(InitialOrderEvent(page: _counter));
                      });
                    }) :
                Container(),
              ],
            ) :
            PageHeaderText(text: "У компании нет заявок!");
          }
          return CustomCircularProgressIndicator();
        },
      ),
    );
  }
}
