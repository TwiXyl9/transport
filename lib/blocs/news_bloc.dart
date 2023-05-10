import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/data_provider/session_data_provider.dart';
import 'package:transport/models/auth.dart';
import 'package:transport/services/api_service.dart';

import '../models/http_exception.dart';
import '../models/news.dart';
import '../models/user.dart';
import '../requests/requests_paths_names.dart';
import 'account_bloc.dart';
import 'authentication_bloc.dart';

@immutable
abstract class NewsEvent {}
class InitialNewsEvent extends NewsEvent {}
class CreateNewsEvent extends NewsEvent {
  News news;
  CreateNewsEvent(this.news);
}
class DeleteNewsEvent extends NewsEvent {
  News news;
  DeleteNewsEvent(this.news);
}
class UpdateNewsEvent extends NewsEvent {
  News news;
  UpdateNewsEvent(this.news);
}

@immutable
abstract class NewsState {}
class NewsInitialState extends NewsState {}
class NewsLoadInProcessState extends NewsState {}
class NewsLoadedState extends NewsState {
  final List<News> news;
  final User user;
  NewsLoadedState(this.news, this.user);
}
class NewsCreateInProcessState extends NewsState {}
class NewsCreatedState extends NewsState {}
class NewsDeleteInProcessState extends NewsState {}
class NewsDeletedState extends NewsState {}
class NewsUpdateInProcessState extends NewsState {}
class NewsUpdatedState extends NewsState {}
class NewsFailureState extends NewsState {
  String error;
  NewsFailureState(this.error);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final _sessionDataProvider = SessionDataProvider();
  final AuthenticationBloc authBloc;
  NewsBloc(this.authBloc) : super(NewsInitialState()) {
    on<NewsEvent>((event, emit) async {
      print(event);
      if (event is InitialNewsEvent) {
        await onInitialNewsEvent(event, emit);
      } else if (event is CreateNewsEvent) {
        await onCreateNewsEvent(event, emit);
      } else if (event is UpdateNewsEvent) {
        await onUpdateNewsEvent(event, emit);
      } else if (event is DeleteNewsEvent) {
        await onDeleteNewsEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialNewsEvent(InitialNewsEvent event, Emitter<NewsState> emit) async {
    List<News> news = [];
    //User user = new User.createGuest();
    try {
      emit(NewsLoadInProcessState());
      var user = await _sessionDataProvider.getUser();
      news = await ApiService().newsIndexRequest(newsPath);
      if (user == null) {
        user = new User.createGuest();
        // var authString = await _sessionDataProvider.getAuthData();
        // var authData = Auth.fromJson(jsonDecode(authString!));
        // var authHeadersMap = authData.mapFromFields();
        // var result = await ApiService().userShowRequest('/users/${user.id}', authHeadersMap);
        // if(result.runtimeType == HttpException){
        //   authBloc.add(AuthenticationLogoutEvent());
        //   emit(NewsFailureState(result.toString()));
        // } else {
        // user = result;
        // _sessionDataProvider.deleteAuthData();
        // _sessionDataProvider.setAuthData(jsonEncode(authHeadersMap));
        //  emit(NewsLoadedState(news, user));
        //}
      }
      emit(NewsLoadedState(news, user!));
    } catch (e) {
      emit(NewsFailureState(e.toString()));
    }

  }
  onCreateNewsEvent(CreateNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsCreateInProcessState());
      var result = await ApiService().createNewsRequest(newsPath, event.news);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(NewsCreatedState());
      } else {
        emit(NewsFailureState(result.toString()));
      }
    } catch (e) {
      emit(NewsFailureState(e.toString()));
    }
  }
  onUpdateNewsEvent(UpdateNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsUpdateInProcessState());
      var result = await ApiService().updateNewsRequest(newsPath, event.news);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(NewsUpdatedState());
      } else {
        emit(NewsFailureState(result.toString()));
      }
    } catch (e) {
      emit(NewsFailureState(e.toString()));
    }
  }
  onDeleteNewsEvent(DeleteNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsDeleteInProcessState());
      var result = await ApiService().deleteNewsRequest(newsPath, event.news);
      print(result.runtimeType);
      if (result.runtimeType != HttpException) {
        emit(NewsDeletedState());
      } else {
        emit(NewsFailureState(result.toString()));
      }
    } catch (e) {
      emit(NewsFailureState(e.toString()));
    }
  }
}
