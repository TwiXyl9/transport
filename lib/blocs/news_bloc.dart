import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transport/services/api_service.dart';

import '../models/news.dart';
import '../requests/requests_paths_names.dart';

@immutable
abstract class NewsEvent {}
class InitialNewsEvent extends NewsEvent {}

@immutable
abstract class NewsState {}
class NewsInitialState extends NewsState {}
class NewsLoadedState extends NewsState {
  final List<News> news;
  NewsLoadedState(this.news);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<News> news = [];
  NewsBloc() : super(NewsInitialState()) {
    on<InitialNewsEvent>((event, emit) async {
      await onInitialNewsEvent(event, emit);
    });
  }
  onInitialNewsEvent(InitialNewsEvent event, Emitter<NewsState> emit) async {
    news = await ApiService().newsIndexRequest(newsPath);
    emit(NewsLoadedState(news));
  }
}
