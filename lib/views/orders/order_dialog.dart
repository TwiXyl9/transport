import 'dart:convert';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transport/blocs/order_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/cars/car_item_order_view.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

import '../../models/service.dart';
import '../../widgets/components/custom_button.dart';
import '../../widgets/components/multi_selector.dart';

class OrderDialog extends StatefulWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late DateTime date;
  late TimeOfDay time;
  int groupValue = 0;
  late Map<int,int> selectedServices = Map<int,int>();

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: DateTime(2101)
  );
  Future<TimeOfDay?> pickTime() => showTimePicker(
    initialTime: TimeOfDay.now(),
    context: context,
    builder: (context, childWidget) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true
          ),
          child: childWidget!
      );
    }
  );
  Future<void> dateAndTimePicker() async {
    DateTime? pickedDateTime;
    DateTime? pickedDate = await pickDate();
    if(pickedDate != null ){
      TimeOfDay? pickedTime = await pickTime();
      if(pickedTime != null ){
        pickedDateTime = DateTime.new(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute
        );
        setState(() {
          dateController.text = DateFormat('dd.MM.yy, HH:mm').format(pickedDateTime!);
        });
      }
    }else{
      print("Date is not selected");
    }
  }

  void showMultiSelect(BuildContext context, List<Service> services) async {
    final items = services.map((e) => MultiSelectDialogItem(e.id, e.name)).toList();

    final selectedValues = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(items, selectedServices);
      },
    );
    selectedServices = selectedValues!;

    print(selectedServices);
  }

  void createOrder(context) {
    if (_formKey.currentState!.validate()) {
      try {
        print(groupValue);
        if(groupValue==0){
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Неудалось отправить заказ!'),
              content: Text("Выберите машину!"),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          );
          return ;
        }
      } catch (error) {
        var errorMessage = error.toString();
        //_showErrorDialog(errorMessage);
      }
      Navigator.of(context).pop();
    }
  }
  callBack(val) {
    setState(() {
      groupValue = val;
    });
  }
    @override
    Widget build(BuildContext context) {
      return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if(state is OrderFailureState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
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
                  constraints: BoxConstraints(minWidth: 200, maxWidth: MediaQuery.of(context).size.width),
                  child: Form(
                    key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          CustomTextField(
                              controller: nameController,
                              hint: 'Имя',
                              type: FieldType.text,
                              validator: (val) {
                                if(!val!.isValidName){
                                  return 'Некорректное имя';
                                }
                              }
                              ),
                          SizedBox(height: 20,),
                          CustomTextField(
                              controller: phoneController,
                              hint: 'Телефон',
                              type: FieldType.text,
                              validator: (val) {
                                if(!val!.isValidPhone){
                                  return 'Некорректный телефон';
                                }
                              }
                              ),
                          SizedBox(height: 20,),
                          TextFormField(
                              controller: dateController,
                              validator: (val){
                                if(val != ''){
                                  if(DateFormat('dd.MM.yy, HH:mm').parse(val!).isBefore(DateTime.now())){
                                    return 'Некорректное время';
                                  }
                                }else{
                                  return 'Выберите дату и время';
                                }
                                },
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today), //icon of text field
                                    labelText: "Выберите дату и время" //label text of field
                              ),
                              readOnly: true,  // when true user cannot edit text
                              onTap: dateAndTimePicker
                          ),
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Text(
                                'Выберите машину',
                              ),
                          ),
                          state is OrderLoadedState ?
                             SizedBox(
                               height: 420,
                               child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      children: state.cars.map((e) => CarItemOrderView(e, callBack, groupValue)).toList()
                                  ),
                             )
                             : CircularProgressIndicator(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Выберите доп. усуги',
                            ),
                          ),
                          state is OrderLoadedState ?

                          // MultiSelectDialogField(
                          //   items: state.services.map((e) => MultiSelectItem(e, e.name)).toList(),
                          //   listType: MultiSelectListType.LIST,
                          //   onConfirm: (values) {
                          //     selectedServices = values;
                          //   },
                          // )
                            ElevatedButton(
                                onPressed:(){ showMultiSelect(context, state.services);},
                                child: Text('Press')
                            )
                              : CircularProgressIndicator(),
                          SizedBox(height: 20,),
                          CustomButton(btnText: "Создать", onTap: () => createOrder(context),),
                        ],
                      ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

