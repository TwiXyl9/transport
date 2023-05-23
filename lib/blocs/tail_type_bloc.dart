import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:transport/requests/requests_paths_names.dart';

import '../data_provider/session_data_provider.dart';
import '../models/http_exception.dart';
import '../models/tail_type.dart';
import '../services/api_service.dart';

@immutable
abstract class TailTypeEvent {}
class InitialTailTypeEvent extends TailTypeEvent {}
class CreateTailTypeEvent extends TailTypeEvent {
  TailType type;
  CreateTailTypeEvent(this.type);
}
class DeleteTailTypeEvent extends TailTypeEvent {
  TailType type;
  DeleteTailTypeEvent(this.type);
}
class UpdateTailTypeEvent extends TailTypeEvent {
  TailType type;
  UpdateTailTypeEvent(this.type);
}

@immutable
abstract class TailTypeState {}
class TailTypeInitialState extends TailTypeState {}
class TailTypeLoadInProcessState extends TailTypeState {}
class TailTypeLoadedState extends TailTypeState {
  final List<TailType> types;
  TailTypeLoadedState(this.types);
}
class TailTypeCreateInProcessState extends TailTypeState {}
class TailTypeCreatedState extends TailTypeState {}
class TailTypeDeleteInProcessState extends TailTypeState {}
class TailTypeDeletedState extends TailTypeState {}
class TailTypeUpdateInProcessState extends TailTypeState {}
class TailTypeUpdatedState extends TailTypeState {}
class TailTypeFailureState extends TailTypeState {
  String error;
  TailTypeFailureState(this.error);
}

class TailTypeBloc extends Bloc<TailTypeEvent, TailTypeState> {
  final _sessionDataProvider = SessionDataProvider();
  TailTypeBloc() : super(TailTypeInitialState()) {
    on<TailTypeEvent>((event, emit) async {
      print(event);
      if (event is InitialTailTypeEvent) {
        await onInitialTailTypeEvent(event, emit);
      } else if (event is CreateTailTypeEvent) {
        await onCreateTailTypeEvent(event, emit);
      } else if (event is UpdateTailTypeEvent) {
        await onUpdateTailTypeEvent(event, emit);
      } else if (event is DeleteTailTypeEvent) {
        await onDeleteTailTypeEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialTailTypeEvent(InitialTailTypeEvent event, Emitter<TailTypeState> emit) async {
    List<TailType> types = [];
    //User user = new User.createGuest();
    try {
      emit(TailTypeLoadInProcessState());
      var user = await _sessionDataProvider.getUser();
      types = await ApiService().tailTypesIndexRequest(tailTypesPath);

      emit(TailTypeLoadedState(types));
    } catch (e) {
      emit(TailTypeFailureState(e.toString()));
    }

  }
  onCreateTailTypeEvent(CreateTailTypeEvent event, Emitter<TailTypeState> emit) async {
    try {
      emit(TailTypeCreateInProcessState());
      var result = await ApiService().createTailTypeRequest(tailTypesPath, event.type);

      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(TailTypeCreatedState());
      } else {
        emit(TailTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(TailTypeFailureState(e.toString()));
    }
  }
  onUpdateTailTypeEvent(UpdateTailTypeEvent event, Emitter<TailTypeState> emit) async {
    try {
      emit(TailTypeUpdateInProcessState());
      var result = await ApiService().updateTailTypeRequest(tailTypesPath, event.type);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(TailTypeUpdatedState());
      } else {
        emit(TailTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(TailTypeFailureState(e.toString()));
    }
  }
  onDeleteTailTypeEvent(DeleteTailTypeEvent event, Emitter<TailTypeState> emit) async {
    try {
      emit(TailTypeDeleteInProcessState());
      var result = await ApiService().delete(tailTypesPath, event.type);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(TailTypeDeletedState());
      } else {
        emit(TailTypeFailureState(result.toString()));
      }
    } catch (e) {
      emit(TailTypeFailureState(e.toString()));
    }
  }
}

