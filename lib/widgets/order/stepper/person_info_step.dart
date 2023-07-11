import 'package:flutter/material.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

class PersonInfoStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  PersonInfoStep(this.formKey, this.nameController, this.phoneController);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 20,),
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
        ],
      ),
    );
  }
}
