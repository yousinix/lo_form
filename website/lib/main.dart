import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'home_page.dart';
import 'util/lo_form_info.dart';
import 'util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoFormInfo.load();
  setUrlStrategy(PathUrlStrategy());
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const theme = AppTheme();
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'LoForm',
          theme: theme.light,
          darkTheme: theme.dark,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: HomePage(
            onThemeChanged: (mode) => setState(() => themeMode = mode),
          ),
        );
      },
    );
  }
}
