import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/account/account_centered_container.dart';
import 'package:transport/widgets/account/account_nested_pages_container.dart';
import 'package:transport/widgets/order/order_button.dart';

import '../../blocs/account_bloc.dart';
import '../components/custom_circular_progress_indicator.dart';
import '../order/order_list_view.dart';

class AccountOrdersView extends StatefulWidget {
  const AccountOrdersView({Key? key}) : super(key: key);

  @override
  State<AccountOrdersView> createState() => _AccountOrdersViewState();
}

class _AccountOrdersViewState extends State<AccountOrdersView> {
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return state is AccountLoadedState ?
          LayoutTemplate(
            child: AccountNestedPagesContainer(
                child: AccountCenteredContainer(
                    child: state.ordersPagination.orders.length > 0?
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
                                context.read<AccountBloc>().add(InitialAccountEvent(page: _counter));
                              });
                            }) :
                        Container(),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("У вас пока нет заказов!", style: TextStyle(fontSize: 24),),
                        OrderButton(context),
                      ],
                    ),

                )
            ),
          ) :
          CustomCircularProgressIndicator();
        }
    );
  }
}