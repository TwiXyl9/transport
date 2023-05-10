import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/widgets/account/account_centered_container.dart';
import 'package:transport/widgets/account/account_nested_pages_container.dart';
import 'package:transport/widgets/order/order_button.dart';

import '../../blocs/account_bloc.dart';
import '../components/custom_circular_progress_indicator.dart';
import '../order/order_list_view.dart';

class AccountOrdersView extends StatelessWidget {
  const AccountOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return state is AccountLoadedState ?
          AccountNestedPagesContainer(
              child: AccountCenteredContainer(
                  child: state.orders.length > 0?
                  OrderListView(state.orders) :
                  Column(
                    children: [
                      Text("У вас пока нет заказов!", style: TextStyle(fontSize: 24),),
                      OrderButton(context),
                    ],
                  ),

              )
          ) :
          CustomCircularProgressIndicator();
        }
    );
  }
}