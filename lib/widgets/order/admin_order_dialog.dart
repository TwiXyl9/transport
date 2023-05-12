import 'package:flutter/material.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';

import '../../models/car.dart';
import '../../models/cargo_type.dart';
import '../../models/order.dart';
import '../../models/order_service.dart';
import '../../models/user.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class AdminOrderDialog extends StatelessWidget {
  final Order order;
  AdminOrderDialog(this.order);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateTimeController = TextEditingController();
  late double totalPrice = 0;
  User user = new User.createGuest();
  Car selectedCar = new Car(0);
  CargoType selectedCargoType = new CargoType(0, '');
  final personInfoFormKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();
  late List<OrderService> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    nameController.text = order.name;
    phoneController.text = order.phone;
    dateTimeController.text = order.dateTime;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          constraints: BoxConstraints(minHeight: 200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 500),
          child: Column(
            children: [
              PersonInfoStep(formKey, nameController, phoneController),
              SizedBox(height: 20,),
              DateStep(dateFormKey, dateTimeController),
              CustomButton(btnText: 'Сохранить', onTap: (){}, btnColor: Colors.green)
            ],
          ),
        ),
      ),
    );
  }
}
