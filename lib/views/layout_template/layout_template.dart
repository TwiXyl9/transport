import 'package:flutter/material.dart';
import 'package:transport/widgets/navigation_bar/navbar.dart';
import 'package:transport/widgets/navigation_drawer/nav_drawer.dart';
import 'package:transport/widgets/order/order_button.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;

  const LayoutTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

