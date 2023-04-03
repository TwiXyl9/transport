import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/components/custom_button.dart';

import '../../blocs/authentication_bloc.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);
  Future<void> logoutClick(AuthenticationBloc bloc) async {
    bloc.add(AuthenticationLogoutEvent());
  }
  @override
  Widget build(BuildContext context) {

    final bloc = context.read<AuthenticationBloc>();

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: 100,
          height: 50,
          child: Center(
            child: CustomButton(btnText: "Выйти", onTap:() => logoutClick(bloc)),
          ),
        );
      },
    );

  }
}
