import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';
import 'package:transport/widgets/account/account_centered_container.dart';
import 'package:transport/widgets/account/account_nested_pages_container.dart';

import '../../blocs/account_bloc.dart';
import '../../models/user.dart';
import '../components/custom_button.dart';
import '../components/custom_circular_progress_indicator.dart';
import '../components/custom_text_field.dart';
import '../error/error_dialog_view.dart';

class AccountSettingsView extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void saveUser(user) async {
      if (_formKey.currentState!.validate()) {
        try {
          user.name = nameController.text;
          user.phone = phoneController.text;
          context.read<AccountBloc>().add(UpdateAccountEvent(user));
        } catch (error) {
          var errorMessage = error.toString();
          showDialog(
              context: context,
              builder: (ctx) => ErrorDialogView(ctx: ctx, message: errorMessage)
          );
        }
      }
    }

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is AccountLoadedState) {
          if (nameController.text.isEmpty && phoneController.text.isEmpty) {
            nameController.text = state.user.name;
            phoneController.text = state.user.phone;
          }
          return AccountNestedPagesContainer(
            child: AccountCenteredContainer(
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
                            if (!val!.isValidName) {
                              return 'Некорректное имя';
                            }
                          }),
                      SizedBox(height: 20,),
                      CustomTextField(
                          controller: phoneController,
                          hint: 'Телефон',
                          type: FieldType.text,
                          validator: (val) {
                            if (!val!.isValidPhone) {
                              return 'Некорректный номер телефона';
                            }
                          }),
                      SizedBox(height: 20,),
                      CustomButton(btnText: "Coхранить", onTap: () => saveUser(state.user), btnColor: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return CustomCircularProgressIndicator();
      },
    );
  }

}
