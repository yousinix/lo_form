import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: const Color(0xFF202124),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.code,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const TextSpan(text: ' with '),
              const WidgetSpan(
                child: Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.red,
                ),
              ),
              const TextSpan(text: ' by '),
              TextSpan(
                text: 'YoussefRaafatNasry',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(kYrnGhUrl);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
