import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'fake_repo.dart';

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
      initialValues: const {
        'name': 'whoami',
      },
      onSubmit: (values) async {
        final name = values['name'] as String;
        final message = await FakeRepo.greet(name);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
      },
      builder: (formState) {
        return Column(
          children: [
            LoField<String>(
              name: 'name',
              builder: (fieldState) => TextFormField(
                initialValue: fieldState.initialValue,
                onChanged: fieldState.onChanged,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: formState.isSubmitting ? null : formState.submit,
              child: const Text('Submit'),
            )
          ],
        );
      },
    );
  }
}
