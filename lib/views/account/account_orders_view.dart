import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/account_bloc.dart';
import '../../widgets/order/order_list_view.dart';

class AccountOrdersView extends StatelessWidget {
  const AccountOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return state is AccountLoadedState ? OrderListView(state.orders) :
          Container();
        }
    );
  }
}