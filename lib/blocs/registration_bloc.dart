import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';

import '../data_provider/session_data_provider.dart';
import '../locator.dart';

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

@immutable
abstract class RegistrationState {}
class RegistrationInitialState extends RegistrationState {}
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
  onRegistrationRedirectToAuthEvent() async {
    locator<NavigationHelper>().router.go(authenticationRoute);
  }
}
