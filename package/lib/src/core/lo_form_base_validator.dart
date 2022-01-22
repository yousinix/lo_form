import 'types.dart';

abstract class LoFormBaseValidator<TKey> {
  /// Returns [ErrMap] containing the error messages for each field depedning
  /// on each its value from [ValMap].
  ErrMap<TKey>? validate(ValMap<TKey> values);

  /// Runs all [validators] on [values], then return the error messages or
  /// `null` accordingly.
  static ErrMap<TKey> run<TKey>(
    List<LoFormBaseValidator<TKey>> validators,
    ValMap<TKey> values,
  ) {
    final ErrMap<TKey> errors = {};

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
