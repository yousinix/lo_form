import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'converters.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        body: RegisterForm(
          onStateChanged: (state) {
            final json = formStateToJson(state);
            window.parent?.postMessage(json, '*');
          },
        ),
      ),
    );
  }
}
