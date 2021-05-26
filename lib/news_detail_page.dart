import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({Key? key, this.url, this.news_title}) : super(key: key);
  final news_title;
  final url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appbar(), body: _body());
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        news_title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      actions: [
        _shareIcon(),
      ],
    );
  }

  Widget _body() {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  Widget _shareIcon() {
    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: _share,
    );
  }

  Future<void> _share() async {
    await Share.share(url);
  }
}
