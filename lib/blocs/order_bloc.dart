import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/models/car.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/models/orders_pagination.dart';
import 'package:transport/models/service.dart';
import 'package:transport/models/user.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';

import '../models/auth.dart';
import '../models/cargo_type.dart';
import '../models/order.dart';

@immutable
abstract class OrderEvent {}
class InitialOrderEvent extends OrderEvent {
  int page;
  InitialOrderEvent({this.page = 1});
}
class CreateOrderEvent extends OrderEvent {
  Order order;
  CreateOrderEvent(this.order);
}
class UpdateOrderEvent extends OrderEvent {
  Order order;
  UpdateOrderEvent(this.order);
}
class DeleteOrderEvent extends OrderEvent {
  Order order;
  DeleteOrderEvent(this.order);
}
@immutable
abstract class OrderState {}
class OrderInitialState extends OrderState {}
class OrderLoadInProcessState extends OrderState {}
class OrderLoadedState extends OrderState {
  final OrdersPagination ordersPagination;
  final List<Service> services;
  final List<CargoType> cargoTypes;
  final List<Car> cars;
  final User user;
  OrderLoadedState(this.ordersPagination, this.services, this.cargoTypes, this.cars, this.user);
}
class OrderCreatedState extends OrderState {}
class OrderUpdatedState extends OrderState {}
class OrderDeletedState extends OrderState {}
class OrderFailureState extends OrderState {
  String error;
  OrderFailureState(this.error);
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _sessionDataProvider = SessionDataProvider();

  OrderBloc() : super(OrderInitialState()) {
    on<OrderEvent>((event, emit) async {
      if (event is InitialOrderEvent) {
        await onInitialOrderEvent(event, emit);
      } else if (event is CreateOrderEvent) {
        await onCreateOrderEvent(event, emit);
      } else if (event is UpdateOrderEvent) {
        await onUpdateOrderEvent(event, emit);
      } else if (event is DeleteOrderEvent) {
        await onDeleteOrderEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialOrderEvent(InitialOrderEvent event, Emitter<OrderState> emit) async {
    List<Car> cars = [];
    OrdersPagination orders;
    List<Service> services = [];
    List<CargoType> cargoTypes = [];
    User user = new User.createGuest();
    String page = '?page=${event.page}';
    try {
      emit(OrderLoadInProcessState());
      orders = await ApiService().orderIndexRequest(ordersPath, page);
      cars = (await ApiService().carsIndexRequest(carsPath, '')).cars;
      services = (await ApiService().additionalServiceIndexRequest(servicesPath, '')).services;
      cargoTypes = await ApiService().cargoTypesIndexRequest(cargoTypesPath);
      var user = await _sessionDataProvider.getUser();
      if (user == null) user = new User.createGuest();
      emit(OrderLoadedState(orders, services, cargoTypes, cars, user));
    } catch (e) {
      print(e.toString());
      emit(OrderFailureState(e.toString()));
    }
  }
  onCreateOrderEvent(CreateOrderEvent event, Emitter<OrderState> emit) async {
    try {
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

  onUpdateOrderEvent(UpdateOrderEvent event, Emitter<OrderState> emit) async {
    try {
      var result = await ApiService().updateOrderRequest(ordersPath, event.order);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(OrderUpdatedState());
        add(InitialOrderEvent());
      } else {
        print(result.toString());
        emit(OrderFailureState(result.toString()));
      }
    } catch (e) {
      print(e.toString());
      emit(OrderFailureState(e.toString()));
    }
  }
  onDeleteOrderEvent(DeleteOrderEvent event, Emitter<OrderState> emit) async {
    try {
      var result = await ApiService().delete(ordersPath, event.order);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(OrderDeletedState());
        add(InitialOrderEvent());
      } else {
        emit(OrderFailureState(result.toString()));
      }
    } catch (e) {
      emit(OrderFailureState(e.toString()));
    }
  }
}
