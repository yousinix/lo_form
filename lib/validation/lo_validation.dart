import '../src/lo_field.dart';

class LoValidation {
  final List<FieldValidateFunc<String>> validators;

  LoValidation() : validators = [];

  FieldValidateFunc<String> build() {
    return (v) {
      for (final validator in validators) {
        final error = validator(v);
        if (error != null) return error;
      }
      return null;
    };
  }

  LoValidation validator({
    required bool Function(String?) validWhen,
    required String defaultError,
    required String? error,
  }) {
    validators.add((v) => validWhen(v) ? null : error ?? defaultError);
    return this;
  }

  LoValidation required([String? error]) {
    return validator(
      validWhen: (v) => v != null && v.isNotEmpty,
      defaultError: 'Required',
      error: error,
    );
  }

  LoValidation match(String? other, [String? error]) {
    return validator(
      validWhen: (v) => v == other,
      defaultError: 'Does not match',
      error: error,
    );
  }

  LoValidation min(int length, [String? error]) {
    return validator(
      validWhen: (v) => (v?.length ?? 0) >= length,
      defaultError: 'Must be $length or more characters',
      error: error,
    );
  }

  LoValidation max(int length, [String? error]) {
    return validator(
      validWhen: (v) => (v?.length ?? 0) <= length,
      defaultError: 'Must be $length or less characters',
      error: error,
    );
  }
}
