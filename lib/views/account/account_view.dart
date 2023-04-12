import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/account_bloc.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/order/order_list_view.dart';

import '../../blocs/authentication_bloc.dart';

class AccountView extends StatelessWidget {

  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<AuthenticationBloc>();

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Container(
          width: 100,
          height: 50,
          child: Center(
            child: Column(
              children: [
                state is AccountLoadedState? OrderListView(state.orders) : Container(),
                CustomButton(btnText: "Выйти", onTap:() => logoutClick(bloc)),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> logoutClick(AuthenticationBloc bloc) async {
    bloc.add(AuthenticationLogoutEvent());
  }
}
