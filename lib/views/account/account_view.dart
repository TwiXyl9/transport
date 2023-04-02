import 'package:flutter/material.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';
import 'package:transport/widgets/components/custom_button.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void logoutClick(){
      AuthService().logout();
      locator<NavigationHelper>().navigateTo(homeRoute);
    }

    return Container(
      width: 100,
      height: 50,
      child: Center(
        child: CustomButton(btnText: "Выйти", onTap: logoutClick),
      ),
    );
  }
}
