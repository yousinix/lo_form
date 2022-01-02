import 'types.dart';

abstract class LoFormBaseValidator {
  /// Returns [ErrMap] containing the error messages for each field depedning
  /// on each its value from [ValMap].
  ErrMap? validate(ValMap values);

  /// Runs all [validators] on [values], then return the error messages or
  /// `null` accordingly.
  static ErrMap run<T>(
    List<LoFormBaseValidator> validators,
    ValMap values,
  ) {
    final ErrMap errors = {};

    for (final validator in validators) {
      final localErrors = validator.validate(values) ?? {};

      // Prevent overwriting errors
      localErrors.removeWhere(
        (key, value) => errors[key] != null,
      );

      errors.addAll(localErrors);
    }

    return errors;
  }
}
