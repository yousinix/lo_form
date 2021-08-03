import 'package:flutter/material.dart';
import 'package:lo_form/lo_form.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoForm Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: NewsletterForm(),
          ),
        ),
      ),
    );
  }
}

class NewsletterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoForm(
      submittableWhen: (status) => status.isValid || status.isSubmitted,
      onSubmit: (values, setErrors) async {
        print('Joined newsletter with ${values.get('email')}');
        return true;
      },
      builder: (form) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoTextField(
              name: 'email',
              validate: LoValidation().email().required().build(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: form.submit,
              child: const Text('Subscribe'),
            ),
          ],
        );
      },
    );
  }
}
