import 'package:flutter/material.dart' hide Banner;
import 'package:sliver_tools/sliver_tools.dart';

import 'util/theme.dart';
import 'widgets/banner.dart';
import 'widgets/footer.dart';
import 'widgets/form_playground.dart';
import 'widgets/navbar.dart';

class HomePage extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const HomePage({
    Key? key,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPinnedHeader(
            child: Navbar(
              onThemeChanged: onThemeChanged,
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/pattern.png',
                  height: Banner.kHeight + 200,
                  width: double.infinity,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withOpacity(0.08),
                  fit: BoxFit.cover,
                ),
                Container(
                  height: Banner.kHeight + 200,
                  color: AppColors.blue400.withOpacity(0.08),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Banner(),
                    FormPlayground(),
                    Footer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
