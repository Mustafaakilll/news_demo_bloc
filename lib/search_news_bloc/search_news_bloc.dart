import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../news_bloc/news_repository.dart';
import '../model/news_article.dart';

part 'search_news_event.dart';
part 'search_news_state.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  SearchNewsBloc(this.newsRepo) : super(InitialSearchNews());

  final NewsRepository newsRepo;

  @override
  Stream<SearchNewsState> mapEventToState(SearchNewsEvent event) async* {
    final _allNews = await newsRepo.getAllNews();
    if (event is SearchKeywordChanged) {
      try {
        final _filteredNews = newsRepo.searchNews(_allNews, event.keyword);
        yield SearchNewsSuccess(news: _filteredNews);
      } on Exception catch (e) {
        yield SearchNewsFailure(e);
      }
    }
  }
}
