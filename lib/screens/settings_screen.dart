import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'welcome_screen.dart';
import 'aboutDeveloper_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                //Go to about dev screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutDeveloperScreen()));
              },
              child: Text(
                'Geliştirici Hakkında',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 100),
            Text(
              'Uygulama sürümü: 1.0',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            Container(
              width: 200,
              height: 50,
              child: RaisedButton(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Çıkış yap',
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                ]),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  //Route to welcome screen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
