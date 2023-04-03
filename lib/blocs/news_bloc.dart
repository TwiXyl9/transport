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
class NewsInitial extends NewsState {}
class NewsLoaded extends NewsState {
  final List<News> news;
  NewsLoaded(this.news);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<News> news = [];
  NewsBloc() : super(NewsInitial()) {
    on<InitialNewsEvent>((event, emit) async {
      news = await ApiService().newsIndexRequest(newsPath);
      emit(NewsLoaded(news));
    });
  }
}
