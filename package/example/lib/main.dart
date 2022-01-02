// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

import 'app.dart';
import 'extensions.dart';
import 'fake_api.dart';

void main() => runApp(const App());

class RegisterForm extends StatelessWidget {
  /// Used in website package to notify for form changes
  final ValueChanged<LoFormState>? onStateChanged;

  const RegisterForm({
    Key? key,
    this.onStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoForm(
      onReady: onStateChanged,
      onChanged: onStateChanged,
      submittableWhen: (status) => status.isValid || status.isSubmitted,
      validators: [
        LoMatchValidator('Password', 'Confirm'),
        LoFormValidator(
          (values) {
            final username = values.get('Username');
            return {
              'Username': username == 'whoami' ? 'Who are you?' : null,
            };
          },
        ),
      ],
      onSubmit: (values, setErrors) async {
        final client = FakeApi();
        final response = await client.register(
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
              initialValue: 'yrn',
              validators: [LoRequiredValidator()],
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Password',
              validators: [
                LoRequiredValidator(),
                LoLengthValidator.min(6),
              ],
              props: const TextFieldProps(
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            LoTextField(
              name: 'Confirm',
              validators: [
                LoRequiredValidator(),
                LoLengthValidator.min(6),
              ],
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
              label: const Text('I agree to all the terms and conditions'),
              validators: [
                LoFieldValidator((v) => v != true ? 'Required' : null),
              ],
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
