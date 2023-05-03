import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/account_bloc.dart';
import 'package:transport/widgets/components/bold_text.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/order/order_list_view.dart';

import '../../blocs/authentication_bloc.dart';
import '../../helpers/navigation_helper.dart';
import '../../locator.dart';
import '../../routing/route_names.dart';

class AccountView extends StatelessWidget {

  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<AuthenticationBloc>();
    context.read<AccountBloc>().add(AccountInitialEvent());
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        print(state);
        return state is AccountLoadedState? Container(
          width: 100,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Профиль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(state.user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(state.user.email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(state.user.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  CustomButton(btnText: "Редактировать", onTap:() => logoutClick(bloc), btnColor: Colors.blue,),
                  CustomButton(btnText: "Заказы", onTap:() => {locator<NavigationHelper>().navigateTo(userOrdersRoute)}, btnColor: Colors.blue,),
                  CustomButton(btnText: "Выйти", onTap:() => logoutClick(bloc), btnColor: Colors.black,),
                ],
              ),
            ),
          ),
        ) :
        Container();
      },
    );
  }
  Future<void> logoutClick(AuthenticationBloc bloc) async {
    bloc.add(AuthenticationLogoutEvent());
  }
}
