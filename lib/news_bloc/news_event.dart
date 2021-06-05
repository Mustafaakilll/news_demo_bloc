part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNews extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class SortNewsByCategory extends NewsEvent {
  final String category;

  SortNewsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
