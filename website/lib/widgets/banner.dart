import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../theme.dart';

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(24),
      color: AppColors.blue400.withOpacity(0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LoForm',
            style: Theme.of(context).textTheme.headline2,
          ),
          const Text("The next-gen lightweight Flutter's form library"),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => launch(kDocsUrl),
            child: const Text('Get Started'),
          )
        ],
      ),
    );
  }
}
