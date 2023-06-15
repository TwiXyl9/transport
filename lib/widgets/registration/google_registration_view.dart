import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';

import '../../blocs/authentication_bloc.dart';
import '../../blocs/registration_bloc.dart';
import '../error/error_dialog_view.dart';

class GoogleRegistrationView extends StatelessWidget {
  final RegistrationGoogleState state;

  GoogleRegistrationView({Key? key, required this.state}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(state.avatar),
          Text(state.user.name),
          Text(state.user.email),
          CustomTextField(
              controller: phoneController,
              hint: 'Телефон',
              type: FieldType.text,
              validator: (val) {
                if(!val!.isValidPhone){
                  return 'Некорректный номер телефона';
                }
              }),
          CustomButton(
              btnText: "Зарегистрироваться",
              onTap:() => googleSignUp(context, state.accessToken),
              btnColor: Colors.black
          ),
        ],
      ),
    );
  }
  Future googleSignUp(BuildContext context, String token) async {
    if(_formKey.currentState!.validate()){
      try {
        final phone = phoneController.text;
        context.read<RegistrationBloc>().add(RegistrationGoogleEvent(token, phone, context.read<AuthenticationBloc>()));
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
