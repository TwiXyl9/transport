import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transport/models/order.dart';
import 'package:transport/services/api_service.dart';

import '../data_provider/session_data_provider.dart';
import '../models/news.dart';
import '../requests/requests_paths_names.dart';

@immutable
abstract class AccountEvent {}
class InitialAccountEvent extends AccountEvent {}

@immutable
abstract class AccountState {}
class AccountInitialState extends AccountState {}
class AccountLoadedState extends AccountState {
  final List<Order> orders;
  AccountLoadedState(this.orders);
}

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final _sessionDataProvider = SessionDataProvider();
  List<Order> orders = [];
  AccountBloc() : super(AccountInitialState()) {
    on<InitialAccountEvent>((event, emit) async {
      await onInitialAccountEvent(event, emit);
    });
  }
  onInitialAccountEvent(InitialAccountEvent event, Emitter<AccountState> emit) async {
    var userId = await _sessionDataProvider.getAccountId();
    if (userId != null) {
      orders = await ApiService().orderIndexRequest(ordersPath);
      orders = orders.where((e) => e.user != null? e.user!.id == userId : ).toList();
    }
    emit(AccountLoadedState(orders));
  }
}
