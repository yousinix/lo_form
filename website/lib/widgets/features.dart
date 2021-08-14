import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../util/theme.dart';

class Features extends StatelessWidget {
  static const features = [
    'No Code Generation',
    'No Boilerplate',
    'Simple and Lightweight',
    'Widgets-approach',
    'Per-field State',
    'API Errors Friendly',
    'Reusable Validation',
    'Validation Builder',
    'Pre-built Fields',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 90.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
              children: const [
                TextSpan(
                  text: 'Everything you need\n',
                ),
                TextSpan(
                  text: 'in one place',
                  style: TextStyle(
                    color: AppColors.blue400,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 64),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 860,
            ),
            child: Wrap(
              children: features
                  .map(
                    (f) => SizedBox(
                      width: 280,
                      child: ListTile(
                        leading: const Icon(Icons.add_circle),
                        title: Text(
                          f,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
