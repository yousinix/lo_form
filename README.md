# LoForm

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

> 🧪 LoForm is still experimental, missing features and bugs are to be expected.

LoForm is a low-code and lightweight Flutter form library,
inspired by [**Formik**](https://formik.org/) — _the world's most popular form library for React, used in production at Airbnb, Stripe, NASA and more_.

## Features

1. **No boilerplate:** 90% less code compared to [bloc](https://bloclibrary.dev/) + [formz](https://pub.dev/packages/formz).
1. **Informational:** provides a lot of useful states (`touched`, `status`, `error`) for each field in the form.
1. **Server-errors friendly:** unlike [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) which requires external errors to be managed by a separate state.
1. **Reusable and easy validation:** uses the builder pattern for building validations.

## Simple Usage

This is a simple example, for a more complex one see the [`RegisterForm`](./example/lib/main.dart) widget.

```dart
class SimpleForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // [1] Wrap your form with [LoForm] widget.
    return LoForm(
      // [2] Choose when the submit button is enabled using form status.
      submittableWhen: (status) => status.isValid || status.isSubmitted,
      // [3] Implement what happens when the form is submitted.
      onSubmit: (values) async {
        print('Hi, ${values.get('name')}!');
        return true; // Successful submission
      },
      builder: (form) {
        return Column(
          children: [
            // [4] Use [LoTextField] instead of the normal [TextField].
            LoTextField(
              // [5] This name will be used to get the field's value.
              name: 'name',
              // [6] Provide a validation scheme using [LoValidation].
              validate: LoValidation().required().build(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              // [7] Call the [submit] method.
              onPressed: form.submit,
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

}
```
