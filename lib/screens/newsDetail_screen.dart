import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class NewsDetail extends StatefulWidget {
  final String url;
  final title;

  const NewsDetail({Key key, this.url, this.title}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final String text = this.widget.title + ' ' + this.widget.url;
              Share.share(text);
            },
          )
        ],
      ),
      body: WebView(
        initialUrl: this.widget.url,
      ),
    );
  }
}
