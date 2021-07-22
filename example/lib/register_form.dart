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
        const weakPasswords = {'123456', 'password'};
        if (weakPasswords.contains(values.get('Password'))) {
          return {'Password': 'Weak password'};
        }
      },
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
              validate: LoValidation()
                  .required()
                  .min(6)
                  .match(form.get('Password'))
                  .build(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: form.status.canSubmit ? form.submit : null,
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }
}
