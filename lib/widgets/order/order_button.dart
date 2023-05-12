import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/views/orders/order_dialog.dart';

import '../../blocs/order_bloc.dart';

class OrderButton extends StatelessWidget {
  BuildContext parentContext;
  OrderButton(this.parentContext);

  Future showOrderDialog() =>
      showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          context.read<OrderBloc>().add(OrderInitialEvent());
          return OrderDialog();
        }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
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
      ),
    );
  }
}
