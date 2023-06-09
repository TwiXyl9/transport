import 'package:flutter/material.dart';
import 'package:transport/locator.dart';
import 'package:transport/helpers/navigation_helper.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  late Function? callback;
  late Color color;
  NavBarItem(this.title, this.navigationPath, {this.callback = null, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback!();
        } else {
          locator<NavigationHelper>().navigateTo(navigationPath);
        }
      },
        child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                color: color
            ),
        )
    );

  }
}