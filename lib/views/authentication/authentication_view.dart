import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/services/oauth_service.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';
import 'package:transport/widgets/components/image_container.dart';
import 'package:transport/helpers/validation_helper.dart';


import '../../widgets/error/error_dialog_view.dart';

class AuthenticationView extends StatefulWidget {

  AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if(state is AuthenticationFailureState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme
                    .of(context)
                    .errorColor,
              ),
            );
          }
        },
        child: LayoutTemplate(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              print(state);
              final bloc = context.read<AuthenticationBloc>();
              if (state is AuthenticationUnauthorizedState || state is AuthenticationFailureState) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300], 
                      borderRadius: BorderRadius.circular(10)
                    ),
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
                                Text("Авторизация", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),),
                                SizedBox(height: 30,),
                                CustomTextField(
                                    controller: emailController,
                                    hint: 'Email',
                                    type: FieldType.text,
                                    validator: (val) {
                                      if (!val!.isValidEmail) {
                                        return 'Некорректный email';
                                      }
                                    }),
                                SizedBox(height: 20,),
                                CustomTextField(
                                    controller: passwordController,
                                    hint: 'Пароль',
                                    type: FieldType.password,
                                    validator: (val) {
                                      if (!val!.isValidPassword) {
                                        return 'Некорректный пароль';
                                      }
                                    }),
                                CustomButton(
                                  btnText: "Войти",
                                  onTap: () => signIn(bloc),
                                  btnColor: Colors.black,
                                ),
                                Container(
                                  child: Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "У вас нет аккаунта? "),
                                            TextSpan(
                                                text: "Зарегистрироваться",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight
                                                        .bold),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    bloc.add(AuthenticationRedirectToRegistrationEvent());
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
                                SizedBox(height: 25,),
                                SignInButton(
                                  Buttons.Google,
                                  onPressed: () {
                                    bloc.add(AuthenticationGoogleLoginEvent());
                                  }
                                ),
                                SizedBox(height: 30,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                );
              }
              return Container();
            },
          ),
        ),
    );
  }

  Future<void> signIn(AuthenticationBloc bloc) async {
    if(_formKey.currentState!.validate()){
      try {
        final email = emailController.text;
        final password = passwordController.text;
        bloc.add(AuthenticationLoginEvent(email: email, password: password));
      } catch (error) {
        var errorMessage = error.toString();
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
        );
      }
    }
  }
}



