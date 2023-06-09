import 'package:flutter/material.dart';
import 'package:transport/widgets/navigation_bar/navbar_item.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String navigationPath;
  late Function? callback;
  DrawerItem(this.title, this.icon, this.navigationPath, {this.callback = null});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 30,
          ),
          NavBarItem(title, navigationPath, callback: callback, color: Colors.black,),
        ],
      ),
    );
  }
}
