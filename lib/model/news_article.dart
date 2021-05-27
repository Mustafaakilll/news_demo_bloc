import 'package:json_annotation/json_annotation.dart';

part 'news_article.g.dart';

@JsonSerializable()
class NewsArticle {
  factory NewsArticle.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleFromJson(json);

  NewsArticle(
      {this.author,
      required this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Map<String, dynamic> toJson(instance) => _$NewsArticleToJson(this);

  final String? author;
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
}
