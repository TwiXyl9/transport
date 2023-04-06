import 'package:flutter/material.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/views/orders/order_dialog.dart';

class OrderButton extends StatelessWidget {
  BuildContext parent_context;
  OrderButton(this.parent_context);

  Future showOrderDialog() =>
      showDialog(
        context: parent_context,
        builder: (BuildContext context) {
          return OrderDialog();
        }
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showOrderDialog(),
      child: Container(
        width: 200,
        height: 80,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
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
