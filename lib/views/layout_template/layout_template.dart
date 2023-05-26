import 'package:flutter/material.dart';
import 'package:transport/views/contacts/contacts_view.dart';
import 'package:transport/widgets/contacts/contact_button.dart';
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
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 23),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                          image: AssetImage('lib/assets/images/hrodno2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Грузоперевозки\nпо городу Гродно',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OrderButton(context),
                                SizedBox(width: 10,),
                                ContactButton()
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
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
                          constraints: BoxConstraints(minWidth: 200, maxWidth: 800),
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
