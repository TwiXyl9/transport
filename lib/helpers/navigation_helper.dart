import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:transport/blocs/authentication_bloc.dart';

import '../data_provider/session_data_provider.dart';
import '../models/user.dart';
import '../routing/route_names.dart';
import '../views/about/about_view.dart';
import '../views/account/account_view.dart';
import '../views/additional_service/additional_service_view.dart';
import '../views/authentication/authentication_view.dart';
import '../views/cargo_type/admin_cargo_type_view.dart';
import '../views/cars/cars_view.dart';
import '../views/contacts/contacts_view.dart';
import '../views/home/home_view.dart';
import '../views/orders/admin_orders_view.dart';
import '../views/registration/registration_view.dart';
import '../views/tail_type/admin_tail_type_view.dart';
import '../widgets/account/account_orders_view.dart';
import '../widgets/account/account_settings_view.dart';

class NavigationHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: homeRoute, builder: ((context, state) => HomeView())),
      GoRoute(path: carsRoute, builder: ((context, state) => CarsView())),
      GoRoute(path: adminCargoTypeRoute, builder: ((context, state) => AdminCargoTypeView())),
      GoRoute(path: adminTailTypeRoute, builder: ((context, state) => AdminTailTypeView())),
      GoRoute(path: adminOrdersRoute, builder: ((context, state) => AdminOrdersView())),
      GoRoute(path: authenticationRoute, builder: ((context, state) => AuthenticationView())),
      GoRoute(path: registrationRoute, builder: ((context, state) => RegistrationView())),
      GoRoute(path: servicesRoute, builder: ((context, state) => AdditionalServiceView())),
      GoRoute(path: contactsRoute, builder: ((context, state) => ContactsView())),
      GoRoute(path: aboutRoute, builder: ((context, state) => AboutView())),
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
      var user = await SessionDataProvider().getUser();
      print(state.location);
      if (user != null) {
        if (state.location == authenticationRoute || state.location == registrationRoute) return homeRoute;
        if ((user.isAdmin() && state.location.contains(accountRoute)) ||
        !user.isAdmin() && state.location.contains(adminPrefixRoute)) return homeRoute;
      } else {
        if (state.location.contains(accountRoute) || state.location.contains(adminPrefixRoute)) return homeRoute;
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
