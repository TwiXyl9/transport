import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/order.dart';
import 'package:transport/routing/route_names.dart';
import 'package:transport/services/api_service.dart';

import '../data_provider/session_data_provider.dart';
import '../models/auth.dart';
import '../models/news.dart';
import '../models/user.dart';
import '../requests/requests_paths_names.dart';
import 'authentication_bloc.dart';

@immutable
abstract class AccountEvent {}
class InitialAccountEvent extends AccountEvent {}
class UpdateAccountEvent extends AccountEvent {
  late User user;
  UpdateAccountEvent(this.user);
}
class RedirectToMainPageAccountEvent extends AccountEvent {}

@immutable
abstract class AccountState {}
class AccountInitialState extends AccountState {}
class AccountLoadedState extends AccountState {
  final List<Order> orders;
  final User user;
  AccountLoadedState(this.user, this.orders);
}
class AccountUpdateInProcessState extends AccountState {}
class AccountUpdatedState extends AccountState {

}
class AccountFailureState extends AccountState {
  String error;
  AccountFailureState(this.error);
}

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _sessionDataProvider = SessionDataProvider();
  final AuthenticationBloc authBloc;
  AccountBloc(this.authBloc) : super(AccountInitialState()) {
    on<AccountEvent>((event, emit) async {
      if (event is InitialAccountEvent) {
        await onInitialAccountEvent(event, emit);
      } else if (event is UpdateAccountEvent) {
        await onUpdateAccountEvent(event, emit);
      } else if (event is RedirectToMainPageAccountEvent) {
        await onRedirectToMainPageAccountEvent(event, emit);
      }
    });
  }
  onInitialAccountEvent(InitialAccountEvent event, Emitter<AccountState> emit) async {
    List<Order> orders = [];
    User user = new User.createGuest();
    var userId = await _sessionDataProvider.getAccountId();
    if (userId != null) {
      orders = await ApiService().usersOrdersIndexRequest('$usersPath/$userId/$ordersPath');

      var authString = await _sessionDataProvider.getAuthData();
      var authData = Auth.fromJson(jsonDecode(authString!));
      var authHeadersMap = authData.mapFromFields();
      var result = await ApiService().userShowRequest('$usersPath/${userId}', authHeadersMap);
      if(result.runtimeType == HttpException){
        authBloc.add(AuthenticationLogoutEvent());
        emit(AccountFailureState(result.toString()));
      } else {
        user = result;
        _sessionDataProvider.deleteAuthData();
        _sessionDataProvider.setAuthData(jsonEncode(authHeadersMap));
        emit(AccountLoadedState(user, orders));
      }
    }
  }
  onUpdateAccountEvent(UpdateAccountEvent event, Emitter<AccountState> emit) async {
    try {
      emit(AccountUpdateInProcessState());
      var authString = await _sessionDataProvider.getAuthData();
      var authData = Auth.fromJson(jsonDecode(authString!));
      var authHeadersMap = authData.mapFromFields();
      var result = await ApiService().updateUserRequest(usersPath, event.user, authHeadersMap);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        _sessionDataProvider.deleteAuthData();
        _sessionDataProvider.setAuthData(jsonEncode(authHeadersMap));
        add(RedirectToMainPageAccountEvent());
        add(InitialAccountEvent());
      } else {
        emit(AccountFailureState(result.toString()));
      }
    } catch (e) {
      emit(AccountFailureState(e.toString()));
    }
  }
  onRedirectToMainPageAccountEvent(RedirectToMainPageAccountEvent event, Emitter<AccountState> emit) async {
    locator<NavigationHelper>().navigateTo(accountRoute);
  }
}
