import 'package:flutter/material.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/helpers/navigation_helper.dart';
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
        children: [
          NavBar(),
          Container(
            child: Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  child,
                  OrderButton(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

