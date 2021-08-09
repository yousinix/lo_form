import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Navbar extends StatelessWidget {
  final VoidCallback onThemeChange;

  const Navbar({
    Key? key,
    required this.onThemeChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'assets/logo.png',
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
                const _NavLink(
                  name: 'Pub',
                  asset: 'assets/logo-dart.png',
                  url: kLoFormPubUrl,
                ),
                const _NavLink(
                  name: 'GitHub',
                  asset: 'assets/logo-github.png',
                  url: kLoFormGhUrl,
                ),
                IconButton(
                  onPressed: onThemeChange,
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.nightlight_round
                        : Icons.wb_sunny_rounded,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String name;
  final String asset;
  final String url;

  const _NavLink({
    Key? key,
    required this.name,
    required this.asset,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      waitDuration: const Duration(milliseconds: 700),
      child: InkWell(
        onTap: () => launch(url),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            asset,
            width: 22,
            color: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ),
      ),
    );
  }
}
