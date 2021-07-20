import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

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
                  _buildFormCard(),
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
                      child: _buildFormCard(),
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

  Widget _buildFormCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RegisterForm(
          onStateChanged: (value) => setState(
            () => formState = value,
          ),
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
            : const Center(
                child: Text(
                  'Form State will appear here,\n'
                  'try changing the form.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ),
      ),
    );
  }
}
