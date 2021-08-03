import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';
import 'package:url_launcher/url_launcher.dart';

import '../misc/constants.dart';
import '../misc/extensions.dart';
import '../misc/fake_api.dart';

class RegisterForm extends StatelessWidget {
  static const kPath = 'website/lib/forms/register_form.dart';

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
            _buildHeader(context),
            const SizedBox(height: 16),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Register Form',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextButton(
          onPressed: () => launch(
            '$kLoFormGhUrl/blob/master/${RegisterForm.kPath}',
          ),
          child: const Tooltip(
            message: 'View Code',
            child: Icon(
              Icons.code,
              size: 18,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }
}
