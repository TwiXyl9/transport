import 'package:flutter/material.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/views/about/about_view.dart';
import 'package:transport/views/account/account_view.dart';
import 'package:transport/views/authentication/authentication_view.dart';
import 'package:transport/views/cars/cars_view.dart';
import 'package:transport/views/home/home_view.dart';
import 'package:transport/views/registration/registration_view.dart';

import '../views/account/account_orders_view.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  print(settings.name);
  switch(settings.name){
    case homeRoute: return _getPageRoute(HomeView(), settings);
    case carsRoute: return _getPageRoute(CarsView(), settings);
    case aboutRoute: return _getPageRoute(AboutView(), settings);
    case authenticationRoute: return _getPageRoute(AuthenticationView(), settings);
    case registrationRoute: return _getPageRoute(RegistrationView(), settings);
    case accountRoute: return _getPageRoute(AccountView(), settings);
    case userOrdersRoute: return _getPageRoute(AccountOrdersView(), settings);
    default: return _getPageRoute(Container(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}