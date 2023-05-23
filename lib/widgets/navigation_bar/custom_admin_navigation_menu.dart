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
    'Тип борта' : adminTailTypeRoute,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: '',
        itemBuilder: (context) => items.entries.map((e) =>
            PopupMenuItem(
                child: Text(e.key,),
                onTap: () => goToPage(e.value),
            )
        ).toList()
    );
  }
  void goToPage(route) {
    locator<NavigationHelper>().navigateTo(route);
  }
}



