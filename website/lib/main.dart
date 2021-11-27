import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'converters.dart';
import 'theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme,
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
