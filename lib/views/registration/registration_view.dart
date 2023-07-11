import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/services/oauth_service.dart';
import 'package:transport/views/layout_template/layout_template.dart';
import 'package:transport/widgets/centered_view/centered_view.dart';
import 'package:transport/widgets/components/custom_button.dart';
import 'package:transport/widgets/components/custom_text_field.dart';
import 'package:transport/widgets/registration/google_registration_view.dart';
import 'package:transport/widgets/registration/user_registration_view.dart';

import '../../blocs/authentication_bloc.dart';
import '../../widgets/error/error_dialog_view.dart';



class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state){
        print(state);
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
      child: LayoutTemplate(
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state){
            final bloc = context.read<RegistrationBloc>();
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: state is RegistrationGoogleState?
                  GoogleRegistrationView(state: state) :
                  UserRegistrationView(),
              ),
            );
          },
        ),
      )
    );
  }
}

