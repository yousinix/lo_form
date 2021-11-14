import 'package:flutter/material.dart';

import 'main.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
