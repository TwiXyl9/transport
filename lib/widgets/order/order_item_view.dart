import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/models/order.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/order/admin_order_dialog.dart';
import 'package:transport/config/order_stages_config.dart';

import '../../blocs/order_bloc.dart';
import '../components/bold_text.dart';
import '../error/error_dialog_view.dart';

class OrderItemView extends StatelessWidget {
  final Order order;
  final bool isAdmin;
  OrderItemView(this.order, this.isAdmin);

  @override
  Widget build(BuildContext context) {

    void canselOrder() {
      try {
        order.stage = cancelStage;
        context.read<OrderBloc>().add(UpdateOrderEvent(order));
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }

    return Card(
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 8.0,
          runSpacing: 10.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText("Заказ № ${order.id}"),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Машина: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    Text("${order.car.brand} ${order.car.model}", style: TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Дата и время: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    Text("${order.dateTime}", style: TextStyle(fontSize: 12),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Стоимость: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                    Text("${order.totalPrice} б.р", style: TextStyle(fontSize: 12),),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Статус: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                Text("${order.stage}", style: TextStyle(fontSize: 12),),
              ],
            ),
            isAdmin?
            CustomButton(
              btnText: "Подробнее",
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdminOrderDialog(order);
                    });
                },
              btnColor: Colors.blueAccent,
              width: 120,
              margin: 0,
            ) :
            order.stage == createdStage?
            CustomButton(
              btnText: "Отменить",
              onTap: canselOrder,
              btnColor: Colors.blueAccent,
              width: 120,
              margin: 0,
            ) :
            Container(),
          ],
        ),
      ),
    );
  }
}
