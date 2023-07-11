import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_drawer/drawer_item.dart';

import '../../blocs/authentication_bloc.dart';
import '../navigation_bar/custom_admin_navigation_menu.dart';

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
                  state is AuthenticationAuthorizedState ?
                  !state.user.isAdmin()?
                  Column(
                    children: [
                      DrawerItem("Контаты", Icons.contact_phone, contactsRoute),
                      DrawerItem("О Нас", Icons.info, aboutRoute),
                      DrawerItem("Личный кабинет", Icons.person, accountRoute),
                    ],
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 84, top: 60),
                        child: CustomAdminNavigationMenu(),
                      ),
                      DrawerItem("Выйти", Icons.logout, '', callback: logout)
                    ],
                  ) :
                  Column(
                    children: [
                      DrawerItem("Контакты", Icons.contact_phone, contactsRoute),
                      DrawerItem("О Нас", Icons.info, aboutRoute),
                      DrawerItem("Войти", Icons.login, authenticationRoute),
                    ],
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
