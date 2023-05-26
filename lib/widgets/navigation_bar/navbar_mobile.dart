import 'package:flutter/material.dart';
import 'package:transport/widgets/navigation_bar/navbar_logo.dart';
class NavBarMobile extends StatefulWidget {
  const NavBarMobile({Key? key}) : super(key: key);

  @override
  State<NavBarMobile> createState() => _NavBarMobileState();
}

class _NavBarMobileState extends State<NavBarMobile> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white,)
          ),
          NavBarLogo(),
        ],
      ),
    );
  }
}

