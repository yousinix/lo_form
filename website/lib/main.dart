import 'package:flutter/material.dart' hide Banner;
import 'package:sliver_tools/sliver_tools.dart';

import 'theme.dart';
import 'widgets/banner.dart';
import 'widgets/footer.dart';
import 'widgets/form_playground.dart';
import 'widgets/navbar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm',
      theme: AppTheme().data,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: Navbar(),
            ),
            SliverToBoxAdapter(
              child: Banner(),
            ),
            SliverToBoxAdapter(
              child: FormPlayground(),
            ),
            SliverToBoxAdapter(
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
