import 'package:flutter/material.dart';
import 'package:transport/widgets/order/order_dialog.dart';

class OrderButton extends StatelessWidget {

  OrderButton({Key? key}) : super(key: key);

  void showOrderDialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDialog();
      }
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showOrderDialog(context),
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
    // return TextButton(
    //   onPressed: onTap,
    //   child: Text("Оставить заявку",
    //     style: TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //         fontSize: 14
    //     ),
    //   ),
    //   style: TextButton.styleFrom(
    //     backgroundColor: Colors.green,
    //   ),
    // );
  }
}
