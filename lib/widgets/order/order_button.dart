import 'package:flutter/material.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/views/orders/order_dialog.dart';

class OrderButton extends StatelessWidget {
  Future showOrderDialog() =>
      showDialog(
        context: locator<NavigationHelper>().navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return OrderDialog();
        }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 80,
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: TextButton(
          onPressed: (){ showOrderDialog(); },
          child: Text(
                "Оставить заявку",
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
