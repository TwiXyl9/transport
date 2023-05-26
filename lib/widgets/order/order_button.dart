import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/widgets/order/order_dialog.dart';

import '../../blocs/order_bloc.dart';

class OrderButton extends StatelessWidget {
  BuildContext parentContext;
  OrderButton(this.parentContext);

  void showOrderDialog(){
    showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return OrderDialog();
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showOrderDialog(),
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.pink,
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
