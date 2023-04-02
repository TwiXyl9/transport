import 'package:flutter/material.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_bar/navbar_item.dart';
import 'package:transport/widgets/navigation_bar/navbar_logo.dart';

class NavBarTabletDesktop extends StatelessWidget {
  const NavBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Prefs.getString('userData') == null ? NavBarItem("Войти", authenticationRoute) :
                  NavBarItem("Личный кабинет", accountRoute),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          )
      );

  }
}
