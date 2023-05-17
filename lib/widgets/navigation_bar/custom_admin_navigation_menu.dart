import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../helpers/navigation_helper.dart';
import '../../locator.dart';
import '../../routing/route_names.dart';

class CustomAdminNavigationMenu extends StatefulWidget {
  CustomAdminNavigationMenu({Key? key}) : super(key: key);

  @override
  State<CustomAdminNavigationMenu> createState() => _CustomAdminNavigationMenuState();
}

class _CustomAdminNavigationMenuState extends State<CustomAdminNavigationMenu> {
  var items = {
    'Заказы' : adminOrdersRoute,
    'Тип груза' : adminCargoTypeRoute,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: '',
        itemBuilder: (context) => [
          PopupMenuItem(child: Text('1')),
          PopupMenuItem(child: Text('2')),
          PopupMenuItem(child: Text('3')),
        ]
    );
  }
}



