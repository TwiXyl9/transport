import 'package:flutter/material.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        locator<NavigationHelper>().navigateTo(contactsRoute)
      },
      child: Container(
        height: 40,
        constraints: BoxConstraints(minWidth:100, maxWidth: 200),
        decoration: BoxDecoration(
            color: Colors.black45.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white)
        ),
        child: Center(
          child: Text(
            "Связаться",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
