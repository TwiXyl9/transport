import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/models/service.dart';
import 'package:transport/models/user.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';

import '../models/auth.dart';
import '../models/cargo_type.dart';
import '../models/order.dart';

@immutable
abstract class OrderEvent {}
class OrderInitialEvent extends OrderEvent {}
class OrderSetCarEvent extends OrderEvent {}
class OrderCreateEvent extends OrderEvent {
  Order order;

  OrderCreateEvent(this.order);
}

@immutable
abstract class OrderState {}
class OrderInitialState extends OrderState {}
class OrderLoadInProcessState extends OrderState {}
class OrderLoadedState extends OrderState {
  final List<Car> cars;
  final List<Service> services;
  final List<CargoType> cargoTypes;
  final User user;
  OrderLoadedState(this.cars, this.services, this.user, this.cargoTypes);
}
class OrderInProcessState extends OrderState {}
class OrderCreatedState extends OrderState {}
class OrderFailureState extends OrderState {
  String error;
  OrderFailureState(this.error);
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _sessionDataProvider = SessionDataProvider();

  OrderBloc() : super(OrderInitialState()) {
    on<OrderEvent>((event, emit) async {
      if (event is OrderInitialEvent) {
        await onOrderInitialEvent(event, emit);
      } else if (event is OrderCreateEvent) {
        await onOrderCreateEvent(event, emit);
      } else if (event is OrderSetCarEvent) {
        await onOrderSetCarEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onOrderInitialEvent(OrderInitialEvent event, Emitter<OrderState> emit) async {
    List<Car> cars = [];
    List<Service> services = [];
    List<CargoType> cargoTypes = [];
    User user = new User(0,'','');
    try {
      emit(OrderLoadInProcessState());
      cars = await ApiService().carsIndexRequest(carsPath);
      services = await ApiService().servicesIndexRequest(servicesPath);
      cargoTypes = await ApiService().cargoTypesIndexRequest(cargoTypesPath);
      var userId = await _sessionDataProvider.getAccountId();
      if (userId != null) {
        var authString = await _sessionDataProvider.getAuthData();
        var authData = Auth.fromJson(jsonDecode(authString!));
        var authHeadersMap = authData.mapFromFields();
        user = await ApiService().userShowRequest('/users/${userId}', authHeadersMap);
      }
      emit(OrderLoadedState(cars, services, user, cargoTypes));
    } catch (e) {
      emit(OrderFailureState(e.toString()));
    }
  }
  onOrderCreateEvent(OrderCreateEvent event, Emitter<OrderState> emit) async {
    try {
      emit(OrderInProcessState());
      var result = await ApiService().createOrderRequest(ordersPath, event.order.shortMapFromFields());
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(OrderCreatedState());
      } else {
        emit(OrderFailureState(result.toString()));
      }
    } catch (e) {
      emit(OrderFailureState(e.toString()));
    }
  }

  onOrderSetCarEvent(OrderSetCarEvent event, Emitter<OrderState> emit) {

  }
}
