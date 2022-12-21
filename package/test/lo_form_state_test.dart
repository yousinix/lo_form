import 'package:flutter_test/flutter_test.dart';
import 'package:lo_form/lo_form.dart';

// Field    | Initial | Validation
// ---------|---------|------------------
// username | tester  | required + min(4)
// password | -       | required

void main() {
  final form = LoFormState();

  setUp(() {
    form.registerField<String>(
      loKey: 'username',
      initialValue: 'tester',
      validators: [
        LoRequiredValidator(),
        LoLengthValidator.min(4),
      ],
    );

    form.registerField<String>(
      loKey: 'password',
      validators: [LoRequiredValidator()],
    );
  });

  group(
    'Fields Registration',
    () {
      test('fields should be 2', () {
        expect(form.fields.length, 2);
        expect(form.fields.containsKey('username'), true);
        expect(form.fields.containsKey('password'), true);
      });

      test('[username] should have an initial value', () {
        expect(form.fields['username']!.initialValue, 'tester');
        expect(form.fields['username']!.value, 'tester');
      });

      test('[password] should not have an initial value', () {
        expect(form.fields['password']!.initialValue, null);
        expect(form.fields['password']!.value, null);
      });
    },
  );

  group(
    'Fields Focus Change',
    () {
      test('[password] should be touched when focused', () {
        form.onFieldFocusChanged<String>('password', true);
        expect(form.fields['password']!.touched, true);
      });

      test('[password] should have an error when unfocused', () {
        form.onFieldFocusChanged<String>('password', false);
        expect(form.fields['password']!.error == null, false);
      });
    },
  );

  group(
    'Fields Value Change',
    () {
      test('[username] should be invalid for short value', () {
        form.onFieldValueChanged('username', 'x');
        expect(form.fields['username']!.status, LoFieldStatus.invalid);
      });

      test('[username] should be pure for initial value', () {
        form.onFieldValueChanged('username', 'tester');
        expect(form.fields['username']!.status, LoFieldStatus.pure);
      });

      test('[username] should be valid for long value', () {
        form.onFieldValueChanged('username', 'long_name');
        expect(form.fields['username']!.status, LoFieldStatus.valid);
      });
    },
  );
}
