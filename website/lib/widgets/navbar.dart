import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/app_icons.dart';
import '../util/constants.dart';

class Navbar extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const Navbar({
    Key? key,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Material(
      elevation: 2,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'LoForm',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => launch(kLoFormPubUrl),
                  icon: const Icon(AppIcons.dart),
                ),
                IconButton(
                  onPressed: () => launch(kLoFormGhUrl),
                  icon: const Icon(AppIcons.github),
                ),
                IconButton(
                  onPressed: () {
                    onThemeChanged(
                      isLightTheme ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                  icon: Icon(
                    isLightTheme
                        ? Icons.nightlight_round
                        : Icons.wb_sunny_rounded,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
