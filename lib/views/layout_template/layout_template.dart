import 'package:flutter/material.dart';
import 'package:transport/views/contacts/contacts_view.dart';
import 'package:transport/widgets/contacts/contact_button.dart';
import 'package:transport/widgets/layout_template/layout_additional_panel.dart';
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/fon.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LayoutAdditionalPanel(),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          padding: EdgeInsets.all(20),
                          constraints: BoxConstraints(maxWidth: 800),
                          child: child

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
