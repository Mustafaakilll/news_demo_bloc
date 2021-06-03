import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/news_article.dart';
import '../news_detail_page.dart';
import 'news_bloc.dart';
import 'news_repository.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) =>
          NewsBloc(context.read<NewsRepository>())..add(GetNews()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Haberler')),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoadedFailureState) {
              return Center(child: Text(state.exception.toString()));
            } else if (state is NewsLoadedSuccessState) {
              return ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  return _successBody(context, state.news[index]);
                },
              );
            }
            return const Center(child: Text('buraya gelirse sictik'));
          },
        ),
      ),
    );
  }

  Widget _successBody(BuildContext context, NewsArticle news) {
    return GestureDetector(
      onTap: () => _goNewsDetail(context, news),
      child: Card(
        child: Row(
          children: [
            _newsImage(news.urlToImage!),
            const SizedBox(width: 10),
            _newsTitle(news.title),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }

  Widget _newsImage(String url) {
    return Image(
      fit: BoxFit.cover,
      height: 100,
      width: 150,
      image: NetworkImage(url),
    );
  }

  Widget _newsTitle(String title) {
    return Expanded(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
      ),
    );
  }

  dynamic _goNewsDetail(BuildContext context, NewsArticle news) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          news_title: news.title,
          url: news.url,
        ),
      ),
    );
  }
}
