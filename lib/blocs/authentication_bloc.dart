import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:transport/blocs/registration_bloc.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';
import 'package:transport/models/http_exception.dart';

import '../models/user.dart';
import '../services/oauth_service.dart';

@immutable
abstract class AuthenticationEvent {}
class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLoginEvent({
    required this.email,
    required this.password,
  });
}
class AuthenticationGoogleLoginEvent extends AuthenticationEvent {
  AuthenticationGoogleLoginEvent();
}
class AuthenticationLogoutEvent extends AuthenticationEvent {}
class AuthenticationCheckStatusEvent extends AuthenticationEvent {}
class AuthenticationRedirectToHomeEvent extends AuthenticationEvent {}
class AuthenticationRedirectToRegistrationEvent extends AuthenticationEvent {}

@immutable
abstract class AuthenticationState {}
class AuthenticationInitial extends AuthenticationState {}
class AuthenticationUnauthorizedState extends AuthenticationState {}
class AuthenticationAuthorizedState extends AuthenticationState {
  User user;
  AuthenticationAuthorizedState(this.user);
}
class AuthenticationFailureState extends AuthenticationState {
  final String error;
  AuthenticationFailureState(this.error);
}
class AuthenticationInProgressState extends AuthenticationState {}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _sessionDataProvider = SessionDataProvider();
  RegistrationBloc registrationBloc;
  AuthenticationBloc(this.registrationBloc) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      print(event);
      if (event is AuthenticationCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthenticationLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthenticationLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      } else if (event is AuthenticationRedirectToHomeEvent) {
        await onAuthRedirectToHomeEvent();
      } else if (event is AuthenticationRedirectToRegistrationEvent) {
        await onAuthRedirectToRegistrationEvent();
      } else if (event is AuthenticationGoogleLoginEvent) {
        await onAuthenticationGoogleLoginEvent(event, emit);
      }
    }, transformer: sequential());
  }

  onAuthCheckStatusEvent(AuthenticationCheckStatusEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgressState());
    final user = await _sessionDataProvider.getUser();

    emit(user != null ? AuthenticationAuthorizedState(user) : AuthenticationUnauthorizedState());
  }

  onAuthLoginEvent(AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationInProgressState());
      final result = await AuthService().login(event.email, event.password,);
      if (result != null && result.runtimeType != HttpException) {
        await _sessionDataProvider.setAuthData(jsonEncode(result.mapFromFields()));
        await _sessionDataProvider.setUser(result.user!);
        emit(AuthenticationAuthorizedState(result.user!));
        onAuthRedirectToHomeEvent();
      } else {
        emit(AuthenticationFailureState(result.toString()));
      }
    } catch (e) {
      print(e.toString());
      emit(AuthenticationFailureState(e.toString()));
    }
  }

  onAuthenticationGoogleLoginEvent(AuthenticationGoogleLoginEvent event, Emitter<AuthenticationState> emit) async {
    GoogleSignInApi googleOmniauth = GoogleSignInApi();
    GoogleSignInAccount googleUser = await googleOmniauth.Login();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    var result = await googleOmniauth.authenticationInSystem({
      'provider': "google_oauth2",
      'accessToken': googleAuth.accessToken,
    });
    if (result.runtimeType == HttpException && result.statusCode == 404) {
      var user = User.createGuest();
      user.email = googleUser.email;
      user.name = googleUser.displayName!;
      registrationBloc.add(RegistrationSetGoogleEvent(user, googleUser.photoUrl!, googleAuth.accessToken!));
      add(AuthenticationRedirectToRegistrationEvent());
    } else if (result.runtimeType != HttpException) {
      await _sessionDataProvider.setAuthData(jsonEncode(result.mapFromFields()));
      await _sessionDataProvider.setUser(result.user!);
      emit(AuthenticationAuthorizedState(result.user!));
      onAuthRedirectToHomeEvent();
    } else {
      emit(AuthenticationFailureState(result.toString()));
    }
  }

  onAuthLogoutEvent(AuthenticationLogoutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _sessionDataProvider.deleteAuthData();
      await _sessionDataProvider.deleteUser();
      emit(AuthenticationUnauthorizedState());
      locator<NavigationHelper>().navigateTo(authenticationRoute);
    } catch (e) {
      emit(AuthenticationFailureState(e.toString()));
    }
  }

  onAuthRedirectToHomeEvent() async {
    locator<NavigationHelper>().navigateTo(homeRoute);
  }

  onAuthRedirectToRegistrationEvent() async {
    locator<NavigationHelper>().navigateTo(registrationRoute);
  }
}
