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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFormCard(
                    separator: const SizedBox(height: 16),
                    padding: 12,
                  ),
                  const SizedBox(height: 16),
                  _buildStateCard(
                    padding: 12,
                  ),
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
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _buildFormCard(),
                    ),
                    const SizedBox(width: 24),
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

  Widget _buildFormCard({
    Widget separator = const Spacer(),
    double padding = 16,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
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

  Widget _buildStateCard({
    double padding = 16,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: formState != null
            ? FormStateSummary(formState!)
            : const SizedBox.shrink(),
      ),
    );
  }
}
