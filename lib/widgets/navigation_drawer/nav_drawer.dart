import 'package:flutter/material.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/navigation_drawer/drawer_item.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Container(
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
              DrawerItem("Услуги", Icons.sell, aboutRoute),
              DrawerItem("Контаты", Icons.contact_phone, carsRoute),
              DrawerItem("О Нас", Icons.info, aboutRoute),
              Prefs.getString('userData') == null? DrawerItem("Войти", Icons.sensor_door, authenticationRoute) :
              DrawerItem("Личный кабинет", Icons.person, accountRoute),
            ],
          ),
        )
    );
  }
}
