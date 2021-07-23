import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'fake_api.dart';

extension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
  }
}

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
        // This method gets called with any change to all form fields,
        // it's useful for validating dependent fields to make sure that
        // they both have the latest value.
        final password = values.get('Password');
        final confirmPassword = values.get('Confirm Password');

        if (password != confirmPassword) {
          return {'Confirm Password': 'Passwords do not match'};
        } else if (password != null && confirmPassword != null) {
          return {'Confirm Password': null}; // Clear error
        }
      },
      submittableWhen: (status) => status.isValid || status.isSubmitted,
      onSubmit: (values, setErrors) async {
        final response = await FakeApi.register(
          username: values.get('Username'),
          password: values.get('Password'),
        );

        if (!response.isError) {
          // Successful submission
          context.showSnackBar('Welcome, ${response.data!}');
          return true;
        } else if (response.validationErrors == null) {
          // Failure submission
          context.showSnackBar(response.message);
          return false;
        } else {
          // Invalid submission (server responded with validation errors)
          setErrors(response.validationErrors!);
        }
      },
      builder: (form) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoTextField(
              name: 'Username',
              validate: LoValidation().required().build(),
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Password',
              validate: LoValidation().required().min(6).build(),
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Confirm Password',
              validate: LoValidation().required().min(6).build(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: form.submit,
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
