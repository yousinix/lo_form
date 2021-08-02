import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../misc/constants.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('LoForm'),
      actions: [
        _buildLink(
          name: 'Pub',
          asset: 'assets/logo-dart.png',
          url: kLoFormPubUrl,
        ),
        _buildLink(
          name: 'GitHub',
          asset: 'assets/logo-github.png',
          url: kLoFormGhUrl,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildLink({
    required String name,
    required String asset,
    required String url,
  }) {
    return Tooltip(
      message: name,
      waitDuration: const Duration(milliseconds: 700),
      child: InkWell(
        splashColor: Colors.white10,
        onTap: () => launch(url),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            asset,
            width: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
