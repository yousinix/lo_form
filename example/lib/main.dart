import 'package:flutter/material.dart';

import 'misc/theme.dart';
import 'widgets/footer.dart';
import 'widgets/form_playground.dart';
import 'widgets/header.dart';

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
        body: FormPlayground(),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
