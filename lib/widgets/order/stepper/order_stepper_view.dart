import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/widgets/order/stepper/cars_step.dart';
import 'package:transport/widgets/order/stepper/date_step.dart';
import 'package:transport/widgets/order/stepper/person_info_step.dart';
import 'package:transport/widgets/order/stepper/services_step.dart';

class OrderStepperView extends StatefulWidget {
  const OrderStepperView({Key? key}) : super(key: key);

  @override
  State<OrderStepperView> createState() => _OrderStepperViewState();
}

class _OrderStepperViewState extends State<OrderStepperView> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
        return Stepper(
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepCancel: () => currentStep == 0
                ? null
                : setState(() {
              currentStep -= 1;
            }),
            onStepContinue: () {
              bool isLastStep = (currentStep == getSteps(state).length - 1);
              if (isLastStep) {
                //Do something with this information
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            steps: getSteps(state)
        );
      }
    );
  }

  List<Step> getSteps(OrderState state){
    return <Step>[
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Личные данные"),
          content: PersonInfoStep()
      ),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Дата"),
          content: DateStep()
      ),
      Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text("Машина"),
          content: state is OrderLoadedState? CarsStep(cars: state.cars) : CircularProgressIndicator(),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: Text("Дополнительные услуги"),
        content: state is OrderLoadedState? ServicesStep(services: state.services) : CircularProgressIndicator(),
      ),
    ];
  }
}
