import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:transport/models/order.dart';
import 'package:transport/services/api_service.dart';

import '../data_provider/session_data_provider.dart';
import '../models/auth.dart';
import '../models/news.dart';
import '../models/user.dart';
import '../requests/requests_paths_names.dart';
import 'authentication_bloc.dart';

@immutable
abstract class AccountEvent {}
class AccountInitialEvent extends AccountEvent {}

@immutable
abstract class AccountState {}
class AccountInitialState extends AccountState {}
class AccountLoadedState extends AccountState {
  final List<Order> orders;
  final User user;
  AccountLoadedState(this.user, this.orders);
}
class AccountWithoutUserState extends AccountState {}
class AccountFailureState extends AccountState {
  String error;
  AccountFailureState(this.error);
}

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _sessionDataProvider = SessionDataProvider();
  final AuthenticationBloc authBloc;
  AccountBloc(this.authBloc) : super(AccountInitialState()) {
    on<AccountInitialEvent>((event, emit) async {
      await onInitialAccountEvent(event, emit);
    });
  }
  onInitialAccountEvent(AccountInitialEvent event, Emitter<AccountState> emit) async {
    List<Order> orders = [];
    User user = new User.createGuest();
    var userId = await _sessionDataProvider.getAccountId();
    if (userId != null) {
      orders = await ApiService().usersOrdersIndexRequest('/users/$userId/orders');

      var authString = await _sessionDataProvider.getAuthData();
      var authData = Auth.fromJson(jsonDecode(authString!));
      var authHeadersMap = authData.mapFromFields();
      var result = await ApiService().userShowRequest('/users/${userId}', authHeadersMap);
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
}
