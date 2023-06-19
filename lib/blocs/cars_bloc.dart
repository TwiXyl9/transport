import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/models/auth.dart';
import 'package:transport/models/http_exception.dart';
import 'package:transport/models/tail_type.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';

import '../models/car.dart';
import '../models/car_pagination.dart';
import '../models/user.dart';

@immutable
abstract class CarsEvent {}
class InitialCarsEvent extends CarsEvent {
  int page;
  InitialCarsEvent(this.page);
}
class CreateCarEvent extends CarsEvent {
  Car car;
  CreateCarEvent(this.car);
}
class DeleteCarEvent extends CarsEvent {
  Car car;
  DeleteCarEvent(this.car);
}
class UpdateCarEvent extends CarsEvent {
  Car car;
  UpdateCarEvent(this.car);
}
@immutable
abstract class CarsState {}
class CarsInitialState extends CarsState {}
class CarsLoadInProcessState extends CarsState {}
class CarsLoadedState extends CarsState {
  final CarsPagination carsPagination;
  final List<TailType> tailTypes;
  final User user;
  CarsLoadedState(this.carsPagination, this.user, this.tailTypes);
}
class CarCreateInProcessState extends CarsState {}
class CarCreatedState extends CarsState {}
class CarDeleteInProcessState extends CarsState {}
class CarDeletedState extends CarsState {}
class CarUpdateInProcessState extends CarsState {}
class CarUpdatedState extends CarsState {}
class CarsFailureState extends CarsState {
  String error;
  CarsFailureState(this.error);
}

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final _sessionDataProvider = SessionDataProvider();
  CarsBloc() : super(CarsInitialState()) {
    on<CarsEvent>((event, emit) async {
      print(event);
      if (event is InitialCarsEvent) {
        await onInitialCarEvent(event, emit);
      } else if (event is CreateCarEvent) {
        await onCreateCarEvent(event, emit);
      } else if (event is UpdateCarEvent) {
        await onUpdateCarEvent(event, emit);
      } else if (event is DeleteCarEvent) {
        await onDeleteCarEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialCarEvent(InitialCarsEvent event, Emitter<CarsState> emit) async {
    CarsPagination carsPagination;
    List<TailType> tailTypes = [];
    //User user = new User.createGuest();
    try {
      emit(CarsLoadInProcessState());
      var user = await _sessionDataProvider.getUser();
      String page = '?page=${event.page}';
      carsPagination = await ApiService().carsIndexRequest(carsPath, page);
      tailTypes = await ApiService().tailTypesIndexRequest(tailTypesPath);
      if (user == null) {
        user = new User.createGuest();
        // var authString = await _sessionDataProvider.getAuthData();
        // var authData = Auth.fromJson(jsonDecode(authString!));
        // var authHeadersMap = authData.mapFromFields();
        // user = await ApiService().userShowRequest('/users/${user.id}', authHeadersMap);
        // _sessionDataProvider.deleteAuthData();
        // _sessionDataProvider.setAuthData(jsonEncode(authHeadersMap));
      }
      emit(CarsLoadedState(carsPagination, user!, tailTypes));
    } catch (e) {
      print(e);
      emit(CarsFailureState(e.toString()));
    }
  }
  onCreateCarEvent(CreateCarEvent event, Emitter<CarsState> emit) async {
    try {
      emit(CarCreateInProcessState());
      var result = await ApiService().createCarRequest(carsPath, event.car);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CarCreatedState());
      } else {
        emit(CarsFailureState(result.toString()));
      }
    } catch (e) {
      emit(CarsFailureState(e.toString()));
    }
  }
  onUpdateCarEvent(UpdateCarEvent event, Emitter<CarsState> emit) async {
    try {
      emit(CarUpdateInProcessState());
      var result = await ApiService().updateCarRequest(carsPath, event.car);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CarUpdatedState());
      } else {
        emit(CarsFailureState(result.toString()));
      }
    } catch (e) {
      emit(CarsFailureState(e.toString()));
    }
  }
  onDeleteCarEvent(DeleteCarEvent event, Emitter<CarsState> emit) async {
    try {
      emit(CarDeleteInProcessState());
      var result = await ApiService().delete(carsPath, event.car);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CarDeletedState());
      } else {
        emit(CarsFailureState(result.toString()));
      }
    } catch (e) {
      emit(CarsFailureState(e.toString()));
    }
  }
}
