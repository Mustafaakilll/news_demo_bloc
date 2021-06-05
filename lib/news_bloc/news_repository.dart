import 'dart:io';

import 'package:dio/dio.dart';
import 'package:turkish/turkish.dart';

import '../model/news_article.dart';

class NewsRepository {
  NewsRepository(this._dio);

  final Dio _dio;

  Future<List<NewsArticle>> getAllNews() async {
    final _uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'tr', 'apiKey': '97604a4cfe784fc7a9ae242ac28b2c87'});

    final response = await _dio.getUri(_uri);
    if (response.statusCode == HttpStatus.ok) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Mesaj ALirken Hata');
    }
  }

  Future<List<NewsArticle>> getNewsByCategory(String category) async {
    final _uri = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': 'tr',
      'category': '$category',
      'apiKey': '97604a4cfe784fc7a9ae242ac28b2c87'
    });
    final response = await _dio.getUri(_uri);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable articles = result['articles'];
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Haberleri filtrelerken hata');
    }
  }

  List<NewsArticle> searchNews(List<NewsArticle> allNews, String keyword) {
    final _filteredNews = <NewsArticle>[];
    allNews.forEach((element) {
      if (element.title.toLowerCaseTr().contains(keyword.toLowerCaseTr())) {
        _filteredNews.add(element);
      }
    });
    return _filteredNews;
  }
}
