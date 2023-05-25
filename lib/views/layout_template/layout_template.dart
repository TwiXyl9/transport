import 'package:flutter/material.dart';
import 'package:transport/views/contacts/contacts_view.dart';
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
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height-50),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Добро пожаловать на мой сайт',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        padding: EdgeInsets.all(20),
                        constraints: BoxConstraints(minWidth: 200, maxWidth: 800),
                        child: ContactsView(),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

