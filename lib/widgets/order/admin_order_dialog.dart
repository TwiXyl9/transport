import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/order/stepper/cars_step.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';
import 'package:transport/widgets/order/stepper/services_step.dart';
import 'package:transport/widgets/order/stepper/total/total_step.dart';
import 'package:transport/widgets/order/total_table_view.dart';
import 'package:transport/models/route.dart' as OrderRoute;
import '../../models/car.dart';
import '../../models/cargo_type.dart';
import '../../models/order.dart';
import '../../models/order_service.dart';
import '../../models/point.dart';
import '../../models/user.dart';
import '../cargo_type/cargo_type_dropdown.dart';
import '../components/custom_button.dart';
import '../components/custom_circular_progress_indicator.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class AdminOrderDialog extends StatefulWidget {
  final Order order;
  AdminOrderDialog(this.order);

  @override
  State<AdminOrderDialog> createState() => _AdminOrderDialogState();
}

class _AdminOrderDialogState extends State<AdminOrderDialog> {
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
  late Order _order;
  void initState() {
    _order = widget.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_order.id != 0) {
      if (allIsEmpty()) {
        nameController.text = _order.name;
        phoneController.text = _order.phone;
        dateTimeController.text = _order.dateTime;
        selectedCargoType = _order.cargoType;
        selectedCar = _order.car;
        selectedServices = _order.services;
        print(selectedServices.length);
      }
    }

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              constraints: BoxConstraints(minHeight: 200, maxHeight: MediaQuery.of(context).size.height, minWidth: 200, maxWidth: 500),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PersonInfoStep(formKey, nameController, phoneController),
                    SizedBox(height: 20,),
                    DateStep(dateFormKey, dateTimeController),
                    SizedBox(height: 20,),SizedBox(height: 20,),
                    state is OrderLoadedState?
                    Column(
                      children: [
                        Text("Выберите тип груза"),
                        CargoTypeDropdown(state.cargoTypes, selectedCargoType, cargoTypesCallback,),
                        SizedBox(height: 20,),
                        CarsStep(carCallback: carsCallback, selectedCar: selectedCar, cars: state.cars),
                        SizedBox(height: 20,),
                        ServicesStep(
                            selectedServices: selectedServices.length == 0 ? state.services.map((e) => new OrderService(0, 0, e)).toList() : selectedServices,
                            servicesCallback: servicesCallback,
                            services: state.services
                        ),
                        SizedBox(height: 20,),
                        TotalTableView(
                          selectedCar.id != 0 ? selectedCar : state.cars[0],
                          selectedServices,
                          totalPrice = getTotalPrice(),)
                      ],
                    ) :
                    CustomCircularProgressIndicator(),
                    CustomButton(btnText: 'Сохранить', onTap: saveOrder, btnColor: Colors.green)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  carsCallback(val) {
    setState(() {
      selectedCar = val;
    });
  }
  servicesCallback(val){
    setState(() {
      selectedServices = val;
    });
  }
  cargoTypesCallback(val){
    setState(() {
      selectedCargoType = val;
    });
  }
  bool allIsEmpty(){
    return nameController.text.isEmpty && phoneController.text.isEmpty &&
        dateTimeController.text.isEmpty && selectedCar.id == 0 &&
        selectedCargoType.id == 0 && selectedServices.isEmpty;
  }
  double getTotalPrice(){
    double result = selectedCar.id! > 0 ? selectedCar.price : 0;
    if (selectedServices.length > 0) {
      selectedServices.forEach((e) {
        result += e.amount * e.service.price;
      });
    }
    return result;
  }
  void saveOrder() {
    try {
      var bloc = context.read<OrderBloc>();
      _order.name = nameController.text;
      _order.phone = phoneController.text;
      _order.dateTime = dateTimeController.text;
      _order.totalPrice = totalPrice;
      _order.cargoType = selectedCargoType;
      _order.car = selectedCar;
      _order.services = selectedServices.where((e) => e.amount > 0).toList();
      //OrderRoute.Route route = new OrderRoute.Route(0, new Point(0, 54.3, 43.3, 'address1'), new Point(0, 55.3, 45.3, 'address2'));
      //Order order = new Order(0, name, phone, dateTime, null, totalPrice, selectedCar, selectedCargoType, route, selectedServices.where((e) => e.amount > 0).toList(), user);
      bloc.add(UpdateOrderEvent(_order));
    } catch (error) {
      var errorMessage = error.toString();
      showDialog(
          context: context,
          builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
      );
    }
    Navigator.of(context).pop();
  }
}
