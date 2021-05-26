part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoadingState extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadedSuccessState extends NewsState {
  final List<NewsArticle> news;

  NewsLoadedSuccessState(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsLoadedFailureState extends NewsState {
  NewsLoadedFailureState(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}
