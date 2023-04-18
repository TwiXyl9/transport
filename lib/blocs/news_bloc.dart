import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:transport/services/api_service.dart';

import '../models/http_exception.dart';
import '../models/news.dart';
import '../requests/requests_paths_names.dart';

@immutable
abstract class NewsEvent {}
class InitialNewsEvent extends NewsEvent {}
class CreateNewsEvent extends NewsEvent {
  News news;
  CreateNewsEvent(this.news);
}

@immutable
abstract class NewsState {}
class NewsInitialState extends NewsState {}
class NewsLoadedState extends NewsState {
  final List<News> news;
  NewsLoadedState(this.news);
}
class NewsCreateInProcessState extends NewsState {}
class NewsCreatedState extends NewsState {}
class NewsFailureState extends NewsState {
  String error;
  NewsFailureState(this.error);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<News> news = [];
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
    news = await ApiService().newsIndexRequest(newsPath);
    emit(NewsLoadedState(news));
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
