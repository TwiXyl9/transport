import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

class DateStep extends StatefulWidget {
  final TextEditingController dateController;
  final GlobalKey<FormState> formKey;

  DateStep(this.formKey, this.dateController);

  @override
  State<DateStep> createState() => _DateStepState();
}

class _DateStepState extends State<DateStep> {
  late var _formKey;
  late var _dateController = TextEditingController();
  @override
  void initState() {
    _formKey = widget.formKey;
    _dateController = widget.dateController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              controller: _dateController,
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
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: _dateController.text.isEmpty? DateTime.now() : DateFormat('dd.MM.yyyy, HH:mm').parse(_dateController.text),
      firstDate:DateTime.now(),
      lastDate: DateTime(2101)
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      initialTime: _dateController.text.isEmpty? TimeOfDay.now() : TimeOfDay.fromDateTime(DateFormat('dd.MM.yyyy, HH:mm').parse(_dateController.text)),
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
          _dateController.text = DateFormat('dd.MM.yyyy, HH:mm').format(pickedDateTime!);
        });
      }
    } else{
      print("Date is not selected");
    }
  }
}
