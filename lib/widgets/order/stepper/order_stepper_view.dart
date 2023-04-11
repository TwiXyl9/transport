import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/widgets/error/error_dialog_view.dart';
import 'package:transport/widgets/order/stepper/cars_step.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';
import 'package:transport/widgets/order/stepper/services_step.dart';
import 'package:transport/widgets/order/stepper/total/total_step.dart';

import '../../../models/service.dart';
import 'cargo_types_step.dart';

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
  int selectedCar = 0;
  int selectedCargoType = 0;
  final personInfoFormKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();
  late Map<int,int> servicesCount = Map<int,int>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          int lastStep = getSteps(state).length - 1;
          bool isLastStep = (currentStep == lastStep);
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
                      if(currentStep!=0) ...[
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
    if(state is OrderLoadedState && state.user != null){
      nameController.text = state.user!.name;
      phoneController.text = state.user!.phone;
    }
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
        state: currentStep > 2 ? fieldAreValid(2) ? StepState.complete : StepState.error : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text("Тип груза"),
        content: state is OrderLoadedState? CargoTypesStep(types: state.cargoTypes, value: selectedCargoType, callback: cargoTypesCallback,) : CircularProgressIndicator(),
      ),
      Step(
          state: currentStep > 3 ? fieldAreValid(3) ? StepState.complete : StepState.error : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text("Машина"),
          content: state is OrderLoadedState? CarsStep(carCallback: carsCallback, selectedCar: selectedCar, cars: state.cars) : CircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: Text("Дополнительные услуги"),
        content: state is OrderLoadedState? ServicesStep(selectedServices: servicesCount.length == 0? servicesCount = { for (var e in state.services) e.id : 0 } : servicesCount, servicesCallback: servicesCallback, services: state.services) : CircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: Text("Итог"),
        content: state is OrderLoadedState? TotalStep(
          name: nameController.text,
          phone: phoneController.text,
          dateTime: dateTimeController.text,
          cargoType: selectedCargoType > 0? state.cargoTypes.where((type) => type.id == selectedCargoType).first : state.cargoTypes[0],
          car: selectedCar > 0? state.cars.where((car) => car.id == selectedCar).first : state.cars[0],
          servicesCount: selectedServicesByNameCount(state.services),) : CircularProgressIndicator(),
      ),
    ];
  }
  bool fieldAreValid(int stepNum){
    bool result = true;
    if (stepNum == 0 && !personInfoFormKey.currentState!.validate()) {
      result = false;
    } else if (stepNum == 1 && !dateFormKey.currentState!.validate()) {
      result = false;
    } else if (stepNum == 2 && selectedCargoType == 0) {
      result = false;
    } else if (stepNum == 3 && selectedCar == 0) {
      result = false;
    }
    return result;
  }
  bool allFieldsValidation(){
    bool result = true;
    if (!dateFormKey.currentState!.validate() || !personInfoFormKey.currentState!.validate() || selectedCar < 1 || selectedCargoType < 1) {
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
      servicesCount = val;
    });
  }
  cargoTypesCallback(val){
    setState(() {
      selectedCargoType = val;
    });
  }
  Map<Service, int> selectedServicesByNameCount(services){
    Map<Service, int> new_map = Map<Service, int>();
    servicesCount.forEach((key, value) {
      if(value > 0) {
        new_map[services
            .firstWhere((serv) => serv.id == key)] = value;
      }
    });
    return new_map;
  }

}
