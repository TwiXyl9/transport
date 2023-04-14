import 'dart:convert';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/cars/car_item_order_view.dart';
import 'package:transport/widgets/components/custom_text_field.dart';
import 'package:transport/widgets/services/service_item_view.dart';

import '../../models/service.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/multi_selector.dart';
import '../../widgets/order/stepper/order_stepper_view.dart';

class OrderDialog extends StatefulWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {

    @override
    Widget build(BuildContext context) {
      return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if(state is OrderFailureState){
          print(state.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Что-то пошло не так. Заявка не создана"),
              backgroundColor: Theme
                  .of(context)
                  .errorColor,
            ),
          );
        }
        if(state is OrderCreatedState){
          CherryToast.success(
            title: Text('Ваша заявка отправлена на рассмотрение!'),
            borderRadius: 0,
          ).show(context);
        }
      },
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadInProcessState || state is OrderInProcessState) {
            return CircularProgressIndicator();
          }
          return Dialog(
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight:200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 800),
                  child: OrderStepperView(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

