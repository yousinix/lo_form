import '../src/lo_field.dart';

// Credits to form-validator (https://github.com/TheMisir/form-validator)
// for inspiring this class's implementation.
// form-validator can be used as an alternative to [LoValidation] for
// more advanced validators (like or-ing) and better localization support
// for error messages.

/// A validation builder class using the builder pattern
/// to build validation functions for [LoField]s
class LoValidation {
  final List<FieldValidateFunc<String>> _validators;

  LoValidation() : _validators = [];

  /// Builds the final validation function that
  /// is used in [LoField]'s [validate] parameter
  FieldValidateFunc<String> build() {
    return (v) {
      for (final validator in _validators) {
        final error = validator(v);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// Adds a new validator to the [_validators] list
  LoValidation _validator({
    required bool Function(String?) validWhen,
    required String defaultError,
    required String? error,
  }) {
    _validators.add((v) => validWhen(v) ? null : error ?? defaultError);
    return this;
  }

  /// String must be neither null nor empty
  LoValidation required([String? error]) {
    return _validator(
      validWhen: (v) => v != null && v.isNotEmpty,
      defaultError: 'Required',
      error: error,
    );
  }

  /// String's length must be more than or equal [length]
  LoValidation min(int length, [String? error]) {
    return _validator(
      validWhen: (v) => (v?.length ?? 0) >= length,
      defaultError: 'Must be $length or more characters',
      error: error,
    );
  }

  /// String's length must be less than or equal [length]
  LoValidation max(int length, [String? error]) {
    return _validator(
      validWhen: (v) => (v?.length ?? 0) <= length,
      defaultError: 'Must be $length or less characters',
      error: error,
    );
  }

  /// String must match [regExp]
  LoValidation regExp(RegExp regExp, [String? error]) {
    return _validator(
      validWhen: (v) => regExp.hasMatch(v!),
      defaultError: 'Does not match',
      error: error,
    );
  }

  /// String must be a valid email
  LoValidation email([String? error]) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp(emailRegExp, 'Invalid email format');
  }
}
