import 'package:flutter/material.dart' hide Banner;
import 'package:flutter/scheduler.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'theme.dart';
import 'widgets/banner.dart';
import 'widgets/footer.dart';
import 'widgets/form_playground.dart';
import 'widgets/navbar.dart';

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
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: Navbar(
                onThemeChange: () {
                  setState(() {
                    themeMode = themeMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  });
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Banner(),
                  FormPlayground(),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
