import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'fake_api.dart';

class RegisterForm extends StatelessWidget {
  final ValueChanged<LoFormState>? onStateChanged;

  const RegisterForm({
    Key? key,
    this.onStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoForm(
      initialValues: const {'Username': 'yrn'},
      onReady: onStateChanged,
      onChanged: onStateChanged,
      validate: (values) {
        const weakPasswords = {'123456', 'password'};

        if (weakPasswords.contains(values['Password'])) {
          return {'Password': 'Weak password'};
        }
      },
      onSubmit: (values) async {
        try {
          final message = await FakeApi.register(
            username: values['Username'] as String,
            password: values['Password'] as String,
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        } catch (e) {
          return {'Username': e.toString()};
        }
      },
      builder: (form) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoTextField(
              name: 'Username',
              validate: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Password',
              validate: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (v.length < 6) {
                  return 'Must be at least 6 characters';
                }
              },
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Confirm Password',
              validate: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (v != form.values['Password']) {
                  return 'Passwords do not match';
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: form.status.isValid ? form.submit : null,
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
