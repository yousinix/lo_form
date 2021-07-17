import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: LoForm(),
      ),
    );
  }
}
