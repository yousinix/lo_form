import 'package:flutter/material.dart';

import 'footer.dart';
import 'header.dart';
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
        appBar: Header(),
        body: HomePage(),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
