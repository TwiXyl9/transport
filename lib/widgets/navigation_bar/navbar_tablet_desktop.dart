import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_bar/navbar_item.dart';
import 'package:transport/widgets/navigation_bar/navbar_logo.dart';

class NavBarTabletDesktop extends StatelessWidget {
  const NavBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    NavBarItem("Контакты", contactsRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem("О Нас", aboutRoute),
                    SizedBox(
                      width: 20,
                    ),
                    state is AuthenticationAuthorizedState ? NavBarItem("Личный кабинет", accountRoute) :
                    NavBarItem("Войти", authenticationRoute),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            )
        );
      },
    );

  }
}
