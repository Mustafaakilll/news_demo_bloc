import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'news_repository.dart';
import '../model/news_article.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(this._newsRepo) : super(NewsLoadingState()) {
    add(GetNews());
  }

  final NewsRepository _newsRepo;

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetNews) {
      yield NewsLoadingState();
      try {
        final news = await _newsRepo.getAllNews();
        yield NewsLoadedSuccessState(news);
      } on Exception catch (e) {
        yield NewsLoadedFailureState(e);
      }
    } else if (event is SortNewsByCategory) {
      yield NewsLoadingState();
      try {
        final news = await _newsRepo.getNewsByCategory(event.category);
        yield NewsLoadedSuccessState(news);
      } on Exception catch (e) {
        yield NewsLoadedFailureState(e);
      }
    }
  }
}
