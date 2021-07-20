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
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1080,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                direction: constraints.maxWidth < 720
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Expanded(
                    child: Card(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RegisterForm(
                            onStateChanged: (value) => setState(
                              () => formState = value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                    height: 16,
                  ),
                  Expanded(
                    child: Card(
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
