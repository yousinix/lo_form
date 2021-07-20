import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'footer.dart';
import 'home_page.dart';
import 'theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm',
      theme: AppTheme().data,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('LoForm'),
          actions: [
            TextButton(
              onPressed: () => launch(kLoFormGhUrl),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'GitHub',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            )
          ],
        ),
        body: HomePage(),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
