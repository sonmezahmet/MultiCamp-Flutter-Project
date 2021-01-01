import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'newsDetail_screen.dart';
import 'settings_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const FEED_URL = 'https://www.aa.com.tr/tr/rss/default?cat=guncel';
  RssFeed _feed;

  void initState() {
    super.initState();
    load();
  }

  updateFeed(feed) async {
    setState(() {
      _feed = feed;
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = await http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {}
    return null;
  }

  load() async {
    loadFeed().then((result) {
      updateFeed(result);
    });
  }

  newsBuilder() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, index) {
        final item = _feed.items[index];
        if (item.title
            .toLowerCase()
            .contains(_searchController.text.toLowerCase())) {
          return ListTile(
            title: title(item.title),
            subtitle: subtitle(item.pubDate.toIso8601String()),
            leading: newsImage(item.imageUrl),
            contentPadding: EdgeInsets.all(10),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetail(
                            url: item.link,
                            title: item.title,
                          )));
            },
          );
        }
        //It is not a most clever way but it works :)
        return SizedBox();
      },
    );
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  subtitle(subtitle) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 16),
    );
  }

  newsImage(imageUrl) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  body() {
    return (_feed == null || _feed.items == null)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : newsBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler'),
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: 150,
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(hintText: 'Ara...'),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {});
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: ()  {
                //Route to settings screen.
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              })
        ],
      ),
      body: body(),
    );
  }
}
