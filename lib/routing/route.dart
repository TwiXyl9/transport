import 'package:flutter/material.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/views/about/about_view.dart';
import 'package:transport/views/account/account_view.dart';
import 'package:transport/views/authentication/authentication_view.dart';
import 'package:transport/views/cars/cars_view.dart';
import 'package:transport/views/home/home_view.dart';
import 'package:transport/views/registration/registration_view.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case homeRoute: return _getPageRoute(HomeView());
    case carsRoute: return _getPageRoute(CarsView());
    case aboutRoute: return _getPageRoute(AboutView());
    case authenticationRoute: return _getPageRoute(AuthenticationView());
    case registrationRoute: return _getPageRoute(RegistrationView());
    case accountRoute: return _getPageRoute(AccountView());
    default: return _getPageRoute(HomeView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}