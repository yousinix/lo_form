import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'home_page.dart';
import 'util/theme.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    final mode = SchedulerBinding.instance?.window.platformBrightness;
    themeMode = mode == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm',
      theme: AppTheme().light,
      darkTheme: AppTheme().dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: HomePage(
        onThemeChange: () {
          setState(() {
            themeMode =
                themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          });
        },
      ),
    );
  }
}
