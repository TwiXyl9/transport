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
class NewsFailureState extends NewsState {
  String error;
  NewsFailureState(this.error);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final _sessionDataProvider = SessionDataProvider();

  NewsBloc() : super(NewsInitialState()) {
    on<NewsEvent>((event, emit) async {
      if (event is InitialNewsEvent) {
        await onInitialNewsEvent(event, emit);
      } else if (event is CreateNewsEvent) {
        await onCreateNewsEvent(event, emit);
      }
    }, transformer: sequential());
  }
  onInitialNewsEvent(InitialNewsEvent event, Emitter<NewsState> emit) async {
    List<News> news = [];
    User user = new User(0,'','');
    try {
      emit(NewsLoadInProcessState());
      var userId = await _sessionDataProvider.getAccountId();
      news = await ApiService().newsIndexRequest(newsPath);
      if (userId != null) {
        var authString = await _sessionDataProvider.getAuthData();
        var authData = Auth.fromJson(jsonDecode(authString!));
        var authHeadersMap = authData.mapFromFields();
        user = await ApiService().userShowRequest('/users/${userId}', authHeadersMap);
        _sessionDataProvider.deleteAuthData();
        _sessionDataProvider.setAuthData(jsonEncode(authHeadersMap));
      }
      emit(NewsLoadedState(news, user));
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
}
