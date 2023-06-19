import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:transport/helpers/navigation_helper.dart';
import 'package:transport/locator.dart';
import 'package:transport/models/order.dart';
import 'package:transport/models/orders_pagination.dart';
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
class InitialAccountEvent extends AccountEvent {
  int page;
  InitialAccountEvent({this.page = 1});
}
class UpdateAccountEvent extends AccountEvent {
  late User user;
  UpdateAccountEvent(this.user);
}
class RedirectToMainPageAccountEvent extends AccountEvent {}

@immutable
abstract class AccountState {}
class AccountInitialState extends AccountState {}
class AccountLoadedState extends AccountState {
  final OrdersPagination ordersPagination;
  final User user;
  AccountLoadedState(this.user, this.ordersPagination);
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
    OrdersPagination orders;
    //User user = new User.createGuest();
    var user = await _sessionDataProvider.getUser();
    if (user != null) {
      var authString = await _sessionDataProvider.getAuthData();
      var authData = Auth.fromJson(jsonDecode(authString!));
      var authHeadersMap = authData.mapFromFields();
      var userInfoResult = await ApiService().userShowRequest('$usersPath/${user.id}', authHeadersMap);
      if (userInfoResult.runtimeType == HttpException) {
        authBloc.add(AuthenticationLogoutEvent());
        emit(AccountFailureState(userInfoResult.toString()));
      }
      user = userInfoResult;
      String page = '?page=${event.page}';
      var ordersResult = await ApiService().usersOrdersIndexRequest('$usersPath/${user!.id}$ordersPath', authHeadersMap, page);
      if(ordersResult.runtimeType == HttpException){
        authBloc.add(AuthenticationLogoutEvent());
        emit(AccountFailureState(ordersResult.toString()));
      } else {
        orders = ordersResult;
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
