import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/account_bloc.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/account/account_centered_container.dart';
import 'package:transport/widgets/components/bold_text.dart';
import 'package:transport/widgets/components/custom_button.dart';

import '../../blocs/authentication_bloc.dart';
import '../../helpers/navigation_helper.dart';
import '../../locator.dart';
import '../../widgets/components/custom_circular_progress_indicator.dart';

class AccountView extends StatelessWidget {

  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthenticationBloc>();
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        print(state);
        return state is AccountLoadedState?
        LayoutTemplate(
          child: AccountCenteredContainer(
            child: Column(
              children: [
                Text('Профиль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                Text(state.user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text(state.user.email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Text(state.user.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                CustomButton(btnText: "Редактировать", onTap:() => { locator<NavigationHelper>().navigateTo('$accountPrefixRoute$accountSettingsRoute', data: state.user) }, btnColor: Colors.blue,),
                CustomButton(btnText: "Заказы", onTap:() => { locator<NavigationHelper>().navigateTo('$accountPrefixRoute$accountOrdersRoute') }, btnColor: Colors.blue,),
                CustomButton(btnText: "Выйти", onTap:() => logoutClick(bloc), btnColor: Colors.black,),
              ],
            ),
          ),
        ) :
        CustomCircularProgressIndicator();
      },
    );
  }

  Future<void> logoutClick(AuthenticationBloc bloc) async {
    bloc.add(AuthenticationLogoutEvent());
  }
}
