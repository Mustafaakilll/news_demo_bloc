part of 'search_news_bloc.dart';

abstract class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();
}

class SearchKeywordChanged extends SearchNewsEvent {
  final String keyword;

  SearchKeywordChanged(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
