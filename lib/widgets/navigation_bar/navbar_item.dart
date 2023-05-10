import 'package:flutter/material.dart';
import 'package:transport/locator.dart';
import 'package:transport/helpers/navigation_helper.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  late Function? callback;
  NavBarItem(this.title, this.navigationPath, {this.callback = null});

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
            style: TextStyle(fontSize: 14),
        )
    );

  }
}