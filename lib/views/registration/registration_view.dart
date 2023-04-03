import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/models/auth.dart';
import 'package:transport/services/auth_service.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';
import 'package:transport/widgets/components/image_container.dart';

import '../../helpers/navigation_helper.dart';
import '../../locator.dart';
import '../../routing/route_names.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Some error'),
        content: Text(message),
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
  }

  void signUp(context) async {
    if(_formKey.currentState!.validate()){
      try {
        final name = nameController.text;
        final phone = phoneController.text;
        final email = emailController.text;
        final password = passwordController.text;
        final confirmPassword = confirmPasswordController.text;
        // Log user in
        final response = await AuthService().signup(name, phone, email, password, confirmPassword);
        // final responseBody = jsonDecode(response.body);
        // if(responseBody['errors']!=null){
        //   print(responseBody['errors']);
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(responseBody['errors']['full_messages'][0]),
        //       backgroundColor: Theme.of(context).errorColor,
        //     ),
        //   );
        // }
        // else{
        //   locator<NavigationHelper>().navigateTo(authenticationRoute);
        //   CherryToast.success(
        //     title: Text('Ваш аккаунт успешно зарегистрирован'),
        //     borderRadius: 0,
        //   ).show(context);
        // }

     } catch (error) {
       var errorMessage = error.toString();
       _showErrorDialog(errorMessage);
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(minWidth: 200, maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text("Регистрация", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
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
                    CustomTextField(
                        controller: emailController,
                        hint: 'Email',
                        type: FieldType.text,
                        validator: (val) {
                          if(!val!.isValidEmail){
                            return 'Некорректный email';
                          }
                        }),
                    SizedBox(height: 20,),
                    CustomTextField(
                        controller: passwordController,
                        hint: 'Пароль',
                        type: FieldType.password,
                        validator: (val){
                          if(!val!.isValidPassword){
                            return 'Некорректный пароль';
                          }
                        }),
                    SizedBox(height: 20,),
                    CustomTextField(
                        controller: confirmPasswordController,
                        hint: 'Повтор пароля',
                        type: FieldType.password,
                        validator: (val){
                          if(!val!.isValidPassword){
                            return 'Некорректный пароль';
                          }else if(val != passwordController.text){
                            return 'Пароли не совпадают';
                          }
                        }),
                    CustomButton(btnText: "Зарегистрироваться", onTap:() => signUp(context),),
                    Container(
                      child: Text.rich(
                          TextSpan(
                              children: [
                                TextSpan(text: "У вас уже есть аккаунта? "),
                                TextSpan(
                                    text: "Войти",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (){
                                        locator<NavigationHelper>().navigateTo(authenticationRoute);
                                      }
                                )
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 25,),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

