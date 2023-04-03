import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

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

  void signUp(RegistrationBloc bloc) async {
    if(_formKey.currentState!.validate()){
      try {
        final name = nameController.text;
        final phone = phoneController.text;
        final email = emailController.text;
        final password = passwordController.text;
        final confirmPassword = confirmPasswordController.text;
        bloc.add(RegistrationSignUpEvent(name, phone, email, password, confirmPassword));

     } catch (error) {
       var errorMessage = error.toString();
       _showErrorDialog(errorMessage);
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state){
        if (state is RegistrationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Theme
                  .of(context)
                  .errorColor,
            ),
          );
        }
        if (state is RegistrationSuccessState) {
          CherryToast.success(
            title: Text('Ваш аккаунт успешно зарегистрирован!'),
            borderRadius: 0,
          ).show(context);
        }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state){
          final bloc = context.read<RegistrationBloc>();
            return Container(
                color: Colors.grey[300],
                child: SafeArea(
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
                            CustomButton(btnText: "Зарегистрироваться", onTap:() => signUp(bloc),),
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
                                                bloc.add(RegistrationRedirectToAuthEvent());
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
        },
      )
    );
  }
}

