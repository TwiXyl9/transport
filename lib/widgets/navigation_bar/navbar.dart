import 'package:flutter/material.dart';
import 'package:transport/widgets/navigation_bar/navbar_item.dart';
import 'package:transport/widgets/navigation_bar/navbar_logo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transport/widgets/navigation_bar/navbar_mobile.dart';
import 'package:transport/widgets/navigation_bar/navbar_tablet_desktop.dart';
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavBarMobile(),
      tablet: NavBarTabletDesktop(),
    );
  }
}


