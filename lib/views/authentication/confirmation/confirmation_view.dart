import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/helpers/validation_helper.dart';

import '../../../helpers/navigation_helper.dart';
import '../../../locator.dart';
import '../../../routing/route_names.dart';
import '../../../services/api_service.dart';
import '../../layout_template/layout_template.dart';

class ConfirmationView extends StatelessWidget {
  final String confirmToken;
  const ConfirmationView({Key? key, required this.confirmToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (confirmToken == 'null') {
      locator<NavigationHelper>().navigateTo(homeRoute);
      return Container();
    }
    return LayoutTemplate(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15.0),
          child: FutureBuilder<dynamic>(
              future: ApiService().confirmEmail(confirmToken),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text('Ваш аккаунт успешно подтвержден!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),
                        SizedBox(height: 15,),
                        Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Теперь вы можете "),
                                TextSpan(
                                    text: "войти",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (){
                                        var bloc = Provider.of<RegistrationBloc>(context, listen: false);
                                        bloc.add(RegistrationRedirectToAuthEvent());
                                      }
                                ),
                                TextSpan(text: " и наслаждаться возможностями нашего сервиса!"),
                              ]
                            )
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text('Вы уже активировали аккаунт, либо срок вашей ссылки истек!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),),
                        SizedBox(height: 15,),
                        Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(text: "Попробуйте "),
                                  TextSpan(
                                      text: "войти",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          var bloc = Provider.of<RegistrationBloc>(context, listen: false);
                                          bloc.add(RegistrationRedirectToAuthEvent());
                                        }
                                  ),
                                  TextSpan(text: " или "),
                                  TextSpan(
                                      text: "зарегистрироваться",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          var bloc = Provider.of<AuthenticationBloc>(context, listen: false);
                                          bloc.add(AuthenticationRedirectToRegistrationEvent());
                                        }
                                  ),
                                  TextSpan(text: " заново! Если возникнут проблемы, "),
                                  TextSpan(
                                      text: "свяжитесь",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          locator<NavigationHelper>().navigateTo(contactsRoute);
                                        }
                                  ),
                                  TextSpan(text: " с нами!"),
                                ]
                            )
                        ),
                      ],
                    );
                  }
                }
                return Container();
              }
          )
      ),
    );
  }
}
