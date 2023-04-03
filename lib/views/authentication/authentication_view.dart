import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/auth.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';
import 'package:transport/widgets/components/image_container.dart';
import 'package:transport/helpers/validation_helper.dart';

import '../../services/auth_service.dart';
class AuthenticationView extends StatefulWidget {

  AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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

  Future<void> signIn() async {
    if(_formKey.currentState!.validate()){
      try {
        final email = emailController.text;
        final password = passwordController.text;

        // final responseBody = jsonDecode(response.body);
        // if(responseBody['errors']!=null){
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(responseBody['errors'][0]),
        //       backgroundColor: Theme.of(context).errorColor,
        //     ),
        //   );
        // }
        // else{
        //   Auth.fromResponse(response);
        //
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
                    Text("Авторизация", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    SizedBox(height: 30,),
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
                    CustomButton(btnText: "Войти", onTap: signIn,),
                    Container(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "У вас нет аккаунта? "),
                            TextSpan(
                              text: "Зарегистрироваться",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  locator<NavigationHelper>().navigateTo(registrationRoute);
                                }
                            )
                          ]
                        )
                      ),
                    ),
                    SizedBox(height: 25,),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )
                        ),
                        Text('Или войдите с помощью',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageContainer(imgPath: 'lib/assets/facebook_logo.png'),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}



