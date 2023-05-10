import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:transport/requests/requests_paths_names.dart';

import '../data_provider/session_data_provider.dart';
import '../models/cargo_type.dart';
import '../models/http_exception.dart';
import '../services/api_service.dart';

@immutable
abstract class CargoTypeEvent {}
class InitialCargoTypeEvent extends CargoTypeEvent {}
class CreateCargoTypeEvent extends CargoTypeEvent {
  CargoType type;
  CreateCargoTypeEvent(this.type);
}
class DeleteCargoTypeEvent extends CargoTypeEvent {
  CargoType type;
  DeleteCargoTypeEvent(this.type);
}
class UpdateCargoTypeEvent extends CargoTypeEvent {
  CargoType type;
  UpdateCargoTypeEvent(this.type);
}

@immutable
abstract class CargoTypeState {}
class CargoTypeInitialState extends CargoTypeState {}
class CargoTypeLoadInProcessState extends CargoTypeState {}
class CargoTypeLoadedState extends CargoTypeState {
  final List<CargoType> types;
  CargoTypeLoadedState(this.types);
}
class CargoTypeCreateInProcessState extends CargoTypeState {}
class CargoTypeCreatedState extends CargoTypeState {}
class CargoTypeDeleteInProcessState extends CargoTypeState {}
class CargoTypeDeletedState extends CargoTypeState {}
class CargoTypeUpdateInProcessState extends CargoTypeState {}
class CargoTypeUpdatedState extends CargoTypeState {}
class CargoTypeFailureState extends CargoTypeState {
  String error;
  CargoTypeFailureState(this.error);
}

class CargoTypeBloc extends Bloc<CargoTypeEvent, CargoTypeState> {
  final _sessionDataProvider = SessionDataProvider();
  CargoTypeBloc() : super(CargoTypeInitialState()) {
    on<CargoTypeEvent>((event, emit) async {
      print(event);
      if (event is InitialCargoTypeEvent) {
        await onInitialCargoTypeEvent(event, emit);
      } else if (event is CreateCargoTypeEvent) {
        await onCreateCargoTypeEvent(event, emit);
      } else if (event is UpdateCargoTypeEvent) {
        await onUpdateCargoTypeEvent(event, emit);
      } else if (event is DeleteCargoTypeEvent) {
        await onDeleteCargoTypeEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialCargoTypeEvent(InitialCargoTypeEvent event, Emitter<CargoTypeState> emit) async {
    List<CargoType> types = [];
    //User user = new User.createGuest();
    try {
      emit(CargoTypeLoadInProcessState());
      var user = await _sessionDataProvider.getUser();
      types = await ApiService().cargoTypesIndexRequest(cargoTypesPath);

      emit(CargoTypeLoadedState(types));
    } catch (e) {
      emit(CargoTypeFailureState(e.toString()));
    }

  }
  onCreateCargoTypeEvent(CreateCargoTypeEvent event, Emitter<CargoTypeState> emit) async {
    try {
      emit(CargoTypeCreateInProcessState());
      var result = await ApiService().createCargoTypeRequest(cargoTypesPath, event.type);

      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CargoTypeCreatedState());
      } else {
        emit(CargoTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(CargoTypeFailureState(e.toString()));
    }
  }
  onUpdateCargoTypeEvent(UpdateCargoTypeEvent event, Emitter<CargoTypeState> emit) async {
    try {
      emit(CargoTypeUpdateInProcessState());
      var result = await ApiService().updateCargoTypeRequest(cargoTypesPath, event.type);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CargoTypeUpdatedState());
      } else {
        emit(CargoTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(CargoTypeFailureState(e.toString()));
    }
  }
  onDeleteCargoTypeEvent(DeleteCargoTypeEvent event, Emitter<CargoTypeState> emit) async {
    try {
      emit(CargoTypeDeleteInProcessState());
      var result = await ApiService().delete(cargoTypesPath, event.type);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(CargoTypeDeletedState());
      } else {
        emit(CargoTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(CargoTypeFailureState(e.toString()));
    }
  }
}

