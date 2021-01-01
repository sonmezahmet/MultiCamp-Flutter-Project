import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geliştirici'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Süleyman Ahmet Sönmez', style: TextStyle(fontSize: 30),),
          SizedBox(height: 100),
          RaisedButton(
            onPressed: () async {
              if (await canLaunch('https://github.com/sonmezahmet')) {
                launch('https://github.com/sonmezahmet');
              }
            },
            child: Text('Github Hesabı', style: TextStyle(fontSize: 20),),
          )
        ]),
      ),
    );
  }
}
