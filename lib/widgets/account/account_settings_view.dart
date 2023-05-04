import 'package:flutter/material.dart';
import 'package:transport/helpers/validation_helper.dart';

import '../../models/user.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class AccountSettingsView extends StatelessWidget {
  final User user;
  AccountSettingsView(this.user);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (nameController.text.isEmpty && phoneController.text.isEmpty) {
      nameController.text = user.name;
      phoneController.text = user.phone;
    }
    void saveUser() async {
      if(_formKey.currentState!.validate()){
        try {
          final name = nameController.text;
          final phone = phoneController.text;
          final email = emailController.text;
          final password = passwordController.text;
          final confirmPassword = confirmPasswordController.text;

        } catch (error) {
          var errorMessage = error.toString();
          showDialog(
              context: context,
              builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
          );
        }
      }
    }

    return Container(
        color: Colors.grey[300],
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          }),
                      SizedBox(height: 20,),
                      CustomTextField(
                          controller: phoneController,
                          hint: 'Телефон',
                          type: FieldType.text,
                          validator: (val) {
                            if(!val!.isValidPhone){
                              return 'Некорректный номер телефона';
                            }
                          }),
                      SizedBox(height: 20,),
                      CustomButton(btnText: "Coхранить", onTap:() => saveUser(), btnColor: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

}
