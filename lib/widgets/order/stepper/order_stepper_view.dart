import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/models/cargo_type.dart';
import 'package:transport/models/route.dart' as OrderRoute;
import 'package:transport/widgets/cargo_type/cargo_type_dropdown.dart';
import 'package:transport/widgets/error/error_dialog_view.dart';
import 'package:transport/widgets/order/stepper/cars_step.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';
import 'package:transport/widgets/order/stepper/services_step.dart';
import 'package:transport/widgets/order/stepper/total/total_step.dart';

import '../../../models/car.dart';
import '../../../models/order.dart';
import '../../../models/order_service.dart';
import '../../../models/point.dart';
import '../../../models/user.dart';
import '../../components/custom_circular_progress_indicator.dart';
import '../../map/map_view.dart';

class OrderStepperView extends StatefulWidget {
  const OrderStepperView({Key? key}) : super(key: key);

  @override
  State<OrderStepperView> createState() => _OrderStepperViewState();
}

class _OrderStepperViewState extends State<OrderStepperView> {
  int currentStep = 0;
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
    return BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          int lastStep = getSteps(state).length - 1;
          bool isLastStep = (currentStep == lastStep);
          if(state is OrderLoadedState && user.id == 0 && state.user.id != 0){
            user = state.user!;
            nameController.text = user.name;
            phoneController.text = user.phone;
          }
          return Stepper(
              type: StepperType.vertical,
              currentStep: currentStep,
              onStepCancel: () => currentStep == 0
                  ? null
                  : setState(() {
                currentStep -= 1;
              }),
              onStepContinue: () {
                if (isLastStep) {
                  createOrder();
                } else {
                  if (fieldAreValid(currentStep)) {
                    if (currentStep == lastStep - 1 && !allFieldsValidation()) {
                      showDialog(
                          context: context,
                          builder: (ctx) => ErrorDialogView(ctx: ctx, message: "Вы не заполнили все поля или не выбрали машину!")
                      );
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  }
                }
              },
              onStepTapped: (step) => {
                if (step == lastStep && !allFieldsValidation()) {
                  showDialog(
                      context: context,
                      builder: (ctx) => ErrorDialogView(ctx: ctx, message: "Вы не заполнили все поля или не выбрали машину!")
                  )
                } else {
                  setState(() {
                    currentStep = step;
                  })
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (currentStep!=0) ...[
                        ElevatedButton(
                          child: Text("Назад"),
                          onPressed: details.onStepCancel,
                        ),
                      ],
                      SizedBox(width: 20,),
                      ElevatedButton(
                        child: isLastStep? Text("Подтвердить") : Text("Далее"),
                        onPressed: details.onStepContinue,
                      ),
                    ],
                  ),
                );
              },
              steps: getSteps(state)
          );
        }
    );
  }

  List<Step> getSteps(OrderState state){
    return <Step>[
      Step(
          state: currentStep > 0 ? fieldAreValid(0) ? StepState.complete : StepState.error : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Личные данные"),
          content: PersonInfoStep(personInfoFormKey, nameController, phoneController)
      ),
      Step(
          state: currentStep > 1 ? fieldAreValid(1) ? StepState.complete : StepState.error : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Дата"),
          content: DateStep(dateFormKey, dateTimeController)
      ),
      Step(
          state: currentStep > 2 ? fieldAreValid(1) ? StepState.complete : StepState.error : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text("Маршрут"),
          content: MapView()
      ),
      Step(
        state: currentStep > 3 ? fieldAreValid(2) ? StepState.complete : StepState.error : StepState.indexed,
        isActive: currentStep >= 3,
        title: Text("Тип груза"),
        content: state is OrderLoadedState? CargoTypeDropdown(state.cargoTypes, selectedCargoType, cargoTypesCallback,) : CustomCircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 4 ? fieldAreValid(3) ? StepState.complete : StepState.error : StepState.indexed,
        isActive: currentStep >= 4,
        title: Text("Машина"),
        content: state is OrderLoadedState? CarsStep(carCallback: carsCallback, selectedCar: selectedCar, cars: state.cars) : CustomCircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: Text("Дополнительные услуги"),
        content: state is OrderLoadedState? ServicesStep(
            selectedServices: selectedServices.length == 0 ? state.services.map((e) => new OrderService(0, 0, e)).toList() : selectedServices,
            servicesCallback: servicesCallback,
            services: state.services
        ) : CustomCircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 6 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 6,
        title: Text("Итог"),
        content: state is OrderLoadedState? TotalStep(
          name: nameController.text,
          phone: phoneController.text,
          dateTime: dateTimeController.text,
          totalPrice: totalPrice = getTotalPrice(),
          cargoType: selectedCargoType.id > 0 ? selectedCargoType : state.cargoTypes[0],
          car: selectedCar.id != 0 ? selectedCar : state.cars[0],
          services: selectedServices,) : CustomCircularProgressIndicator(),
      ),
    ];
  }
  bool fieldAreValid(int stepNum){
    bool result = true;
    if (stepNum == 0 && !personInfoFormKey.currentState!.validate()) {
      result = false;
    } else if (stepNum == 1 && !dateFormKey.currentState!.validate()) {
      result = false;
    } else if (stepNum == 2 && selectedCargoType.id == 0) {
      result = false;
    } else if (stepNum == 3 && selectedCar.id == 0) {
      result = false;
    }
    return result;
  }
  bool allFieldsValidation(){
    bool result = true;
    if (!dateFormKey.currentState!.validate() ||
        !personInfoFormKey.currentState!.validate() ||
        selectedCar.id == 0 ||
        selectedCargoType.id < 1) {
      result = false;
    }
    return result;
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
  double getTotalPrice(){
    double result = selectedCar.id! > 0 ? selectedCar.pricePerHour : 0;
    if (selectedServices.length > 0) {
      selectedServices.forEach((e) {
        result += e.amount * e.service.price;
      });
    }
    return result;
  }
  void createOrder() {
    try {
      var bloc = context.read<OrderBloc>();
      var name = nameController.text;
      var phone = phoneController.text;
      var dateTime = dateTimeController.text;
      OrderRoute.Route route = new OrderRoute.Route(0, new Point(0, 54.3, 43.3, 'address1'), new Point(0, 55.3, 45.3, 'address2'));
      Order order = new Order(0, name, phone, dateTime, null, totalPrice, selectedCar, selectedCargoType, route, selectedServices.where((e) => e.amount > 0).toList(), user);
      bloc.add(CreateOrderEvent(order));
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
