import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/blocs/authentication_bloc.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';
import 'package:transport/services/oauth_service.dart';

import '../data_provider/session_data_provider.dart';
import '../locator.dart';
import '../models/user.dart';

@immutable
abstract class RegistrationEvent {}
class RegistrationInitialEvent extends RegistrationEvent {}
class RegistrationRedirectToAuthEvent extends RegistrationEvent {}
class RegistrationSignUpEvent extends RegistrationEvent {
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;
  RegistrationSignUpEvent(this.name, this.phone, this.email, this.password, this.confirmPassword);
}

class RegistrationGoogleEvent extends RegistrationEvent {
  String phone;
  String accessToken;
  AuthenticationBloc authBloc;
  RegistrationGoogleEvent(this.accessToken, this.phone, this.authBloc);
}

class RegistrationSetGoogleEvent extends RegistrationEvent {
  User user;
  String avatar;
  String accessToken;
  RegistrationSetGoogleEvent(this.user, this.avatar, this.accessToken);
}

@immutable
abstract class RegistrationState {}
class RegistrationInitialState extends RegistrationState {}
class RegistrationGoogleState extends RegistrationState {
  User user;
  String avatar;
  String accessToken;
  RegistrationGoogleState(this.user, this.avatar,this.accessToken);
}
class RegistrationInProcessState extends RegistrationState {}
class RegistrationSuccessState extends RegistrationState {}
class RegistrationFailureState extends RegistrationState {
  String error;
  RegistrationFailureState(this.error);
}


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final _sessionDataProvider = SessionDataProvider();
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegistrationEvent>((event, emit) async {
      print(event);
      if (event is RegistrationSignUpEvent) {
        await onRegistrationSignUpEvent(event, emit);
      } else if (event is RegistrationRedirectToAuthEvent) {
        await onRegistrationRedirectToAuthEvent();
      } else if (event is RegistrationGoogleEvent) {
        await onRegistrationGoogleEvent(event, emit);
      } else if (event is RegistrationSetGoogleEvent) {
        await onRegistrationSetGoogleEvent(event, emit);
      }
    }, transformer: sequential());
  }

  onRegistrationSignUpEvent(RegistrationSignUpEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationInProcessState());
      final result = await AuthService().signup(event.name, event.phone, event.email, event.password, event.confirmPassword);
      print(result);
      if(result.runtimeType != HttpException){
        emit(RegistrationSuccessState());
        onRegistrationRedirectToAuthEvent();
      } else{
        emit(RegistrationFailureState(result.toString()));
      }
    } catch (e) {
      emit(RegistrationFailureState(e.toString()));
    }
  }

  onRegistrationGoogleEvent(RegistrationGoogleEvent event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationInProcessState());
      GoogleSignInApi googleOmniauth = GoogleSignInApi();
      var result = await googleOmniauth.registration(event.accessToken, event.phone);
      print(result);
      if(result.runtimeType != HttpException){
        await _sessionDataProvider.setAuthData(jsonEncode(result.mapFromFields()));
        await _sessionDataProvider.setUser(result.user!);
        event.authBloc.emit(AuthenticationAuthorizedState(result.user!));
        event.authBloc.add(AuthenticationRedirectToHomeEvent());
      } else{
        emit(RegistrationFailureState(result.toString()));
      }
    } catch (e) {
      emit(RegistrationFailureState(e.toString()));
    }
  }

  onRegistrationRedirectToAuthEvent() async {
    locator<NavigationHelper>().navigateTo(authenticationRoute);
  }

  onRegistrationSetGoogleEvent(RegistrationSetGoogleEvent event, Emitter<RegistrationState> emit) async {
    emit(RegistrationGoogleState(event.user,event.avatar, event.accessToken));
  }
}
