import 'package:flutter/material.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/helpers/navigation_helper.dart';
class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          locator<NavigationHelper>().navigateTo(homeRoute);
        },
        child: SizedBox(
          height: 100,
          width: 100,
          child: Image.asset('lib/assets/delivery.png'),
        ),
    );
    // return SizedBox(
    //   height: 100,
    //   width: 100,
    //   child: Image.asset('lib/assets/delivery.png'),
    //
    // );
  }
}
