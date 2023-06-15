import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_button.dart';

import '../../blocs/registration_bloc.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class UserRegistrationView extends StatelessWidget {
  UserRegistrationView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<RegistrationBloc>();
    void signUp() async {
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
          showDialog(
              context: context,
              builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
          );
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25,),
          Text("Регистрация", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
          SizedBox(height: 15,),
          CustomTextField(
              controller: nameController,
              hint: 'Имя',
              type: FieldType.text,
              validator: (val) {
                if(!val!.isValidName){
                  return 'Некорректное имя';
                }
              }),
          SizedBox(height: 10,),
          CustomTextField(
                controller: phoneController,
                hint: 'Телефон',
                type: FieldType.text,
                validator: (val) {
                  if(!val!.isValidPhone){
                    return 'Некорректный номер телефона';
                  }
                }),
          SizedBox(height: 10,),
          CustomTextField(
                controller: emailController,
                hint: 'Email',
                type: FieldType.text,
                validator: (val) {
                  if(!val!.isValidEmail){
                    return 'Некорректный email';
                  }
                }),
          SizedBox(height: 10,),
          CustomTextField(
                controller: passwordController,
                hint: 'Пароль',
                type: FieldType.password,
                validator: (val){
                  if(!val!.isValidPassword){
                    return 'Некорректный пароль';
                  }
                }),
          SizedBox(height: 10,),
          CustomTextField(
                controller: confirmPasswordController,
                hint: 'Повтор пароля',
                type: FieldType.password,
                validator: (val){
                  if (!val!.isValidPassword) {
                    return 'Некорректный пароль';
                  } else if (val != passwordController.text) {
                    return 'Пароли не совпадают';
                  }
                }),
          CustomButton(
              btnText: "Зарегистрироваться",
              onTap:() => signUp(),
              btnColor: Colors.black
          ),
          Container(
            child: Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: "У вас уже есть аккаунт? "),
                      TextSpan(
                          text: "Войти",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                            bloc.add(RegistrationRedirectToAuthEvent());
                          }),
                    ]
                )
            ),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );
  }
}
