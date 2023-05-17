import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_drawer/drawer_item.dart';

import '../../blocs/authentication_bloc.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logout(){
      var bloc = Provider.of<AuthenticationBloc>(context, listen: false);
      bloc.add(AuthenticationLogoutEvent());
    }
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return SafeArea(
            child: Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 16)
                ],
              ),
              child: Column(
                children: <Widget>[
                  DrawerItem("Автопарк", Icons.directions_car, carsRoute),
                  DrawerItem("Услуги", Icons.sell, servicesRoute),
                  DrawerItem("Контаты", Icons.contact_phone, carsRoute),
                  DrawerItem("О Нас", Icons.info, aboutRoute),
                  state is AuthenticationAuthorizedState ?
                  !state.user.isAdmin()?
                  DrawerItem("Личный кабинет", Icons.person, accountRoute) :
                  DrawerItem("Выйти", Icons.logout, '', callback: logout) :
                  DrawerItem("Войти", Icons.login, authenticationRoute),
                ],
              ),
            )
        );
      },
    );
  }
}
