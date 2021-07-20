import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'form_state_summary.dart';
import 'register_form.dart';
import 'theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      theme: AppTheme().data,
      debugShowCheckedModeBanner: false,
      home: HomPage(),
    );
  }
}

class HomPage extends StatefulWidget {
  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  LoFormState? formState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1080,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final direction = constraints.maxWidth < 720
                    ? Axis.vertical
                    : Axis.horizontal;

                return Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  direction: direction,
                  children: [
                    Expanded(
                      child: Card(
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
      ),
    );
  }
}
