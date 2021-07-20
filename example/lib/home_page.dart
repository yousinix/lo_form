import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'form_state_summary.dart';
import 'register_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoFormState? formState;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(
      left: 24,
      right: 24,
      top: 24,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFormCard(
                    separator: const SizedBox(height: 16),
                  ),
                  SizedBox(height: padding.top),
                  _buildStateCard(),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1080,
              ),
              child: Padding(
                padding: padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _buildFormCard(
                        separator: const Spacer(),
                      ),
                    ),
                    SizedBox(width: padding.left),
                    Expanded(
                      child: _buildStateCard(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFormCard({required Widget separator}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RegisterForm(
              onStateChanged: (value) => setState(
                () => formState = value,
              ),
            ),
            separator,
            TextButton.icon(
              onPressed: () => launch(
                '$kLoFormGhUrl/blob/master/example/lib/register_form.dart',
              ),
              icon: const Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.black45,
              ),
              label: const Text(
                'View Code',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: formState != null
            ? FormStateSummary(formState!)
            : const SizedBox.shrink(),
      ),
    );
  }
}
