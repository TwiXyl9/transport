import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/views/contacts/contacts_view.dart';
import 'package:transport/widgets/contacts/contact_button.dart';
import 'package:transport/widgets/footer/footer_view.dart';
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/fon.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                          future: SessionDataProvider().getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isAdmin()) return Container();
                            }
                            return LayoutAdditionalPanel();
                          }
                      ),
                      Container(
                        padding: EdgeInsets.all(kIsWeb? 20 : 0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(horizontal:  kIsWeb? 40 : 0),
                            padding: EdgeInsets.all(20),
                            constraints: BoxConstraints(maxWidth: 800),
                            child: child
                          ),
                        ),
                      ),
                      FooterView(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
