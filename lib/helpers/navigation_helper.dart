import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/authentication_bloc.dart';

import '../data_provider/session_data_provider.dart';
import '../models/user.dart';
import '../routing/route_names.dart';
import '../views/account/account_view.dart';
import '../views/authentication/authentication_view.dart';
import '../views/cars/cars_view.dart';
import '../views/home/home_view.dart';
import '../views/registration/registration_view.dart';
import '../widgets/account/account_orders_view.dart';
import '../widgets/account/account_settings_view.dart';

class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: homeRoute, builder: ((context, state) => HomeView())),
      GoRoute(path: carsRoute, builder: ((context, state) => CarsView())),
      GoRoute(path: authenticationRoute, builder: ((context, state) => AuthenticationView())),
      GoRoute(path: registrationRoute, builder: ((context, state) => RegistrationView())),
      GoRoute(
          path: accountRoute,
          builder: ((context, state) => AccountView()),
          routes: [
            GoRoute(path: accountOrdersRoute, builder: ((context, state) => AccountOrdersView())),
            GoRoute(path: accountSettingsRoute, builder: ((context, state) => AccountSettingsView())),
          ]

      ),
    ],
    redirect: (context, state) async {
      bool isAuth = await SessionDataProvider().getAccountId() != null;
      print(isAuth);
      print(state.location);
      if (isAuth) {
        if (state.fullPath == authenticationRoute || state.fullPath == registrationRoute) return homeRoute;
      } else {
        if (state.location.contains(accountRoute)) return homeRoute;
      }
      return state.fullPath;
    },
  );

  void navigateTo(String routeName, {data = null}){
    return router.go(routeName, extra: data);
  }

  void goBack(){
    router.pop();
  }
}
