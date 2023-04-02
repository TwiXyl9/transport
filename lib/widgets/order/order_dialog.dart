import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/models/prefs.dart';
import 'package:transport/services/api_service.dart';
import 'package:transport/widgets/cars/cars_item_view.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

import '../../models/car.dart';
import '../../models/service.dart';
import '../../requests/requests_paths_names.dart';
import '../components/custom_button.dart';

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
  late List<Object?> selectedServices;
  void takeUserData(){
    if(Prefs.getString('userData') != null){
      var userData = jsonDecode(Prefs.getString('userData')!);
      nameController.text = userData['name'];
      phoneController.text = userData['phone'];
    }
  }
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
      takeUserData();
      return Dialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
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
                        print(val);
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
                  FutureBuilder<List<Car>>(
                    future: ApiService().carsIndexRequest(carsPath),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(
                          child: Text('An error has occurred!'),
                        );
                      } else if (snapshot.hasData) {
                        return Expanded(
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              children: snapshot.data!.map((e) => CarsItemView(e, callBack, groupValue)).toList()
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  //SizedBox(height: 20,),
                  // FutureBuilder<List<Service>>(
                  //   future: ApiService().servicesIndexRequest(servicesPath),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       print(snapshot.error);
                  //       return const Center(
                  //         child: Text('An error has occurred!'),
                  //       );
                  //     } else if (snapshot.hasData) {
                  //       return MultiSelectDialogField(
                  //         items: snapshot.data!.map((e) => MultiSelectItem(e, e.name)).toList(),
                  //         listType: MultiSelectListType.CHIP,
                  //         onConfirm: (values) {
                  //           selectedServices = values;
                  //         },
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 20,),
                  CustomButton(btnText: "Создать", onTap: () => createOrder(context),),
                ],
              ),
            ),
          ),
        ),
      );
  }
}

