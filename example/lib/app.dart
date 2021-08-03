import 'package:flutter/material.dart';

import 'main.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
