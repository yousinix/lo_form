import 'package:flutter/material.dart' hide Banner;
import 'package:sliver_tools/sliver_tools.dart';

import 'util/theme.dart';
import 'widgets/banner.dart';
import 'widgets/features.dart';
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
    final textColor = Theme.of(context).textTheme.bodyText1!.color!;

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
                Container(
                  height: Banner.kHeight + 250,
                  decoration: BoxDecoration(
                    color: AppColors.blue400.withOpacity(0.08),
                    image: DecorationImage(
                      image: const AssetImage('assets/images/pattern.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        textColor.withOpacity(0.064),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Banner(),
                    FormPlayground(),
                    Features(),
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
