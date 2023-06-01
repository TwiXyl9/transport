import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:transport/requests/requests_paths_names.dart';

import '../data_provider/session_data_provider.dart';
import '../models/cargo_type.dart';
import '../models/http_exception.dart';
import '../models/service.dart';
import '../models/user.dart';
import '../services/api_service.dart';

@immutable
abstract class AdditionalServiceEvent {}
class InitialAdditionalServiceEvent extends AdditionalServiceEvent {}
class CreateAdditionalServiceEvent extends AdditionalServiceEvent {
  Service service;
  CreateAdditionalServiceEvent(this.service);
}
class DeleteAdditionalServiceEvent extends AdditionalServiceEvent {
  Service service;
  DeleteAdditionalServiceEvent(this.service);
}
class UpdateAdditionalServiceEvent extends AdditionalServiceEvent {
  Service service;
  UpdateAdditionalServiceEvent(this.service);
}

@immutable
abstract class AdditionalServiceState {}
class AdditionalServiceInitialState extends AdditionalServiceState {}
class AdditionalServiceLoadInProcessState extends AdditionalServiceState {}
class AdditionalServiceLoadedState extends AdditionalServiceState {
  final List<Service> services;
  final User user;
  AdditionalServiceLoadedState(this.services, this.user);
}
class AdditionalServiceCreateInProcessState extends AdditionalServiceState {}
class AdditionalServiceCreatedState extends AdditionalServiceState {}
class AdditionalServiceDeleteInProcessState extends AdditionalServiceState {}
class AdditionalServiceDeletedState extends AdditionalServiceState {}
class AdditionalServiceUpdateInProcessState extends AdditionalServiceState {}
class AdditionalServiceUpdatedState extends AdditionalServiceState {}
class AdditionalServiceFailureState extends AdditionalServiceState {
  String error;
  AdditionalServiceFailureState(this.error);
}

class AdditionalServiceBloc extends Bloc<AdditionalServiceEvent, AdditionalServiceState> {
  final _sessionDataProvider = SessionDataProvider();
  AdditionalServiceBloc() : super(AdditionalServiceInitialState()) {
    on<AdditionalServiceEvent>((event, emit) async {
      print(event);
      if (event is InitialAdditionalServiceEvent) {
        await onInitialAdditionalServiceEvent(event, emit);
      } else if (event is CreateAdditionalServiceEvent) {
        await onCreateAdditionalServiceEvent(event, emit);
      } else if (event is UpdateAdditionalServiceEvent) {
        await onUpdateAdditionalServiceEvent(event, emit);
      } else if (event is DeleteAdditionalServiceEvent) {
        await onDeleteAdditionalServiceEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialAdditionalServiceEvent(InitialAdditionalServiceEvent event, Emitter<AdditionalServiceState> emit) async {
    List<Service> services = [];
    //User user = new User.createGuest();
    try {
      print('Helllo');
      emit(AdditionalServiceLoadInProcessState());
      var user = await _sessionDataProvider.getUser();
      if (user == null) user = new User.createGuest();
      services = await ApiService().additionalServiceIndexRequest(servicesPath);
      print(services.length);
      emit(AdditionalServiceLoadedState(services, user));
    } catch (e) {
      print(e.toString());
      emit(AdditionalServiceFailureState(e.toString()));
    }

  }
  onCreateAdditionalServiceEvent(CreateAdditionalServiceEvent event, Emitter<AdditionalServiceState> emit) async {
    try {
      emit(AdditionalServiceCreateInProcessState());
      var result = await ApiService().create(servicesPath, event.service);

      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(AdditionalServiceCreatedState());
      } else {
        emit(AdditionalServiceFailureState(result.toString()));
      }
    } catch (e) {
      emit(AdditionalServiceFailureState(e.toString()));
    }
  }
  onUpdateAdditionalServiceEvent(UpdateAdditionalServiceEvent event, Emitter<AdditionalServiceState> emit) async {
    try {
      emit(AdditionalServiceUpdateInProcessState());
      var result = await ApiService().updateWithFiles(servicesPath, event.service);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(AdditionalServiceUpdatedState());
      } else {
        emit(AdditionalServiceFailureState(result.toString()));
      }
    } catch (e) {
      emit(AdditionalServiceFailureState(e.toString()));
    }
  }
  onDeleteAdditionalServiceEvent(DeleteAdditionalServiceEvent event, Emitter<AdditionalServiceState> emit) async {
    try {
      emit(AdditionalServiceDeleteInProcessState());
      var result = await ApiService().delete(servicesPath, event.service);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(AdditionalServiceDeletedState());
      } else {
        emit(AdditionalServiceFailureState(result.toString()));
      }
    } catch (e) {
      emit(AdditionalServiceFailureState(e.toString()));
    }
  }
}

