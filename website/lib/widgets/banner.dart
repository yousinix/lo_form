import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/constants.dart';

class Banner extends StatelessWidget {
  static const kHeight = 280.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LoForm',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            'Lightweight Flutter form library',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.color
                  ?.withOpacity(0.64),
            ),
          ),
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
