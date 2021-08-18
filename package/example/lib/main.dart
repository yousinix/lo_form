import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'app.dart';
import 'extensions.dart';
import 'fake_api.dart';

void main() => runApp(App());

class RegisterForm extends StatelessWidget {
  static const kPath = 'example/lib/main.dart';

  /// Used in website package to notify for form changes
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
        final confirmPassword = values.get('Confirm');

        if (password != confirmPassword) {
          return {'Confirm': 'Passwords do not match'};
        } else if (password != null && confirmPassword != null) {
          return {'Confirm': null}; // Clear error
        }
      },
      submittableWhen: (status) => status.isValid || status.isSubmitted,
      onSubmit: (values, setErrors) async {
        final response = await FakeApi.register(
          username: values.get('Username'),
          password: values.get('Password'),
        );

        if (!response.isError) {
          context.showSnackBar('Welcome, ${response.data!}');
          return true; // Successful submission
        } else if (response.validationErrors == null) {
          context.showSnackBar(response.message);
          return false; // Failed submission
        } else {
          // Invalid submission (API errors)
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
              props: const TextFieldProps(
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Confirm',
              validate: LoValidation().required().min(6).build(),
              props: const TextFieldProps(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
            ),
            const SizedBox(height: 16),
            LoCheckbox(
              name: 'Agreement',
              validate: (value) => value != true ? 'Required' : null,
              label: const Text('I agree to all the terms and conditions'),
            ),
            const Spacer(),
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
