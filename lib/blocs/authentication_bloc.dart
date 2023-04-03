import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/auth_service.dart';

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
class AuthenticationLogoutEvent extends AuthenticationEvent {}
class AuthenticationCheckStatusEvent extends AuthenticationEvent {}

@immutable
abstract class AuthenticationState {}
class AuthenticationInitial extends AuthenticationState {}
class AuthenticationUnauthorizedState extends AuthenticationState {}
class AuthenticationAuthorizedState extends AuthenticationState {}
class AuthenticationFailureState extends AuthenticationState {
  final Object error;
  AuthenticationFailureState(this.error);
}
class AuthenticationInProgressState extends AuthenticationState {}
class AuthenticationCheckStatusInProgressState extends AuthenticationState {}



class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _sessionDataProvider = SessionDataProvider();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthenticationLoginEvent) {
        await onAuthLoginEvent(event, emit);
      } else if (event is AuthenticationLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthenticationCheckStatusEvent());
  }

  onAuthCheckStatusEvent(AuthenticationCheckStatusEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgressState());
    final authData = await _sessionDataProvider.getAuthData();
    final newState = authData != null ? AuthenticationAuthorizedState() : AuthenticationUnauthorizedState();
    emit(newState);
  }

  onAuthLoginEvent(AuthenticationLoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthenticationInProgressState());
      final authData = await AuthService().login(event.email, event.password,);
      await _sessionDataProvider.setAuthData(jsonEncode(authData.mapFromFields()));
      await _sessionDataProvider.setAccountId(authData.userId!);
      emit(AuthenticationAuthorizedState());
      locator<NavigationHelper>().navigateTo(homeRoute);
    } catch (e) {
      emit(AuthenticationFailureState(e));
    }
  }

  onAuthLogoutEvent(AuthenticationLogoutEvent event, Emitter<AuthenticationState> emit) async {

  }
}
