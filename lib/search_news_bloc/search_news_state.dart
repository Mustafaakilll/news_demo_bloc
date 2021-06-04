part of 'search_news_bloc.dart';

abstract class SearchNewsState extends Equatable {
  const SearchNewsState();
}

class InitialSearchNews extends SearchNewsState {
  @override
  List<Object?> get props => [];
}

class SearchNewsSuccess extends SearchNewsState {
  final List<NewsArticle>? news;

  SearchNewsSuccess({this.news});

  @override
  List<Object?> get props => [news];
}

class SearchNewsFailure extends SearchNewsState {
  final Exception exception;

  SearchNewsFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}
