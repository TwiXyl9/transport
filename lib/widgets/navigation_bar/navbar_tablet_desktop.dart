import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_bar/custom_admin_navigation_menu.dart';
import 'package:transport/widgets/navigation_bar/navbar_item.dart';
import 'package:transport/widgets/navigation_bar/navbar_logo.dart';

class NavBarTabletDesktop extends StatelessWidget {
  const NavBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logout(){
      var bloc = Provider.of<AuthenticationBloc>(context, listen: false);
      bloc.add(AuthenticationLogoutEvent());
    }
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                NavBarLogo(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    NavBarItem("Автопарк", carsRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem("Услуги", servicesRoute),
                    SizedBox(
                      width: 20,
                    ),

                    state is AuthenticationAuthorizedState ?
                    !state.user.isAdmin()?
                    Row(
                      children: [
                        NavBarItem("Контакты", contactsRoute),
                        SizedBox(
                          width: 20,
                        ),
                        NavBarItem("О Нас", aboutRoute),
                        SizedBox(
                          width: 20,
                        ),
                        NavBarItem("Личный кабинет", accountRoute),
                      ],
                    ) :
                    Row(
                      children: [
                        CustomAdminNavigationMenu(),
                        SizedBox(width: 20,),
                        NavBarItem("Выйти", '', callback: logout,),
                      ],
                    ) :
                    Row(
                      children: [
                        NavBarItem("Контакты", contactsRoute),
                        SizedBox(
                          width: 20,
                        ),
                        NavBarItem("О Нас", aboutRoute),
                        SizedBox(
                          width: 20,
                        ),
                        NavBarItem("Войти", authenticationRoute),
                      ],
                    ),
                    SizedBox(width: 20,),
                  ],
                )
              ],
            )
        );

      },
    );

  }
}
