import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transport/requests/requests_paths_names.dart';
import 'package:transport/services/api_service.dart';

import '../models/car.dart';

@immutable
abstract class CarsEvent {}
class InitialCarEvent extends CarsEvent {}

abstract class CarsState {}
class CarsInitial extends CarsState {}
class CarsLoaded extends CarsState {
  final List<Car> cars;
  CarsLoaded(this.cars);
}

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  List<Car> cars = [];
  CarsBloc() : super(CarsInitial()) {
    on<InitialCarEvent>((event, emit) async {
     cars = await ApiService().carsIndexRequest(carsPath);
     emit(CarsLoaded(cars));
    });
  }
}
