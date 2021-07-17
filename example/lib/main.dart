import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: HelloForm(),
          ),
        ),
      ),
    );
  }
}

class HelloForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoForm(
      initialValues: {
        'name': 'whoami',
      },
      onSubmit: (values) {
        final name = values['name'] as String;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Hello, $name! 👋'),
            ),
          );
      },
      builder: (state) {
        return Column(
          children: [
            LoField<String>(
              name: 'name',
              builder: (initialValue, onChanged) => TextFormField(
                initialValue: initialValue,
                onChanged: onChanged,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: state.submit,
              child: Text('Submit'),
            )
          ],
        );
      },
    );
  }
}
