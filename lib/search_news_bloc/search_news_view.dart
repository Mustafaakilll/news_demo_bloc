import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/news_article.dart';
import '../news_bloc/news_repository.dart';
import '../news_detail_page.dart';
import 'search_news_bloc.dart';

class SearchNewsPage extends StatelessWidget {
  const SearchNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchNewsBloc(context.read<NewsRepository>()),
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: BlocBuilder<SearchNewsBloc, SearchNewsState>(
            builder: (context, state) {
              if (state is InitialSearchNews) {
                return Container();
              } else if (state is SearchNewsFailure) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              } else if (state is SearchNewsSuccess) {
                return ListView.builder(
                  itemCount: state.news!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _successBody(context, state.news![index]);
                  },
                );
              } else {
                return const Center(
                  child: Text('Buraya Gelirse Sictik'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: BlocBuilder<SearchNewsBloc, SearchNewsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration:
                  const InputDecoration(hintText: 'Aramak Istediginiz Haber'),
              onChanged: (value) => context
                  .read<SearchNewsBloc>()
                  .add(SearchKeywordChanged(value)),
            ),
          );
        },
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

  void _goNewsDetail(BuildContext context, NewsArticle news) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          news_title: news.title,
          url: news.url,
        ),
      ),
    );
  }
}
