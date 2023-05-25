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
    // return ScreenTypeLayout(
    //   mobile: NavBarMobile(),
    //   tablet: NavBarTabletDesktop(),
    // );
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.lightBlue.shade400,
                Colors.blue.shade800,
              ],
            )
        ),
        height: 50,
        child: ScreenTypeLayout(
          mobile: NavBarMobile(),
          tablet: NavBarTabletDesktop(),
        ),
      )
    );
  }
}


