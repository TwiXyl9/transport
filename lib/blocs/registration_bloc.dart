import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';

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
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegistrationEvent>((event, emit) async {
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
      final authData = await AuthService().signup(event.name, event.phone, event.email, event.password, event.confirmPassword);
      if(authData.errorMsg == null){
        emit(RegistrationSuccessState());
        onRegistrationRedirectToAuthEvent();
      } else{
        emit(RegistrationFailureState(authData.errorMsg!));
      }
    } catch (e) {
      emit(RegistrationFailureState(e.toString()));
    }
  }
  onRegistrationRedirectToAuthEvent() async {
    locator<NavigationHelper>().navigateTo(authenticationRoute);
  }
}
