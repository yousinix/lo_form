abstract class LoFieldBaseValidator<TValue> {
  /// Returns `String` containing the error message if [value] is invalid.
  /// or `null` when [value] is valid.
  String? validate(TValue? value);

  /// Runs all [validators] on [value], then return the error message or
  /// `null` accordingly.
  static String? run<TValue>(
    List<LoFieldBaseValidator> validators,
    TValue value,
  ) {
    for (final validator in validators) {
      final error = validator.validate(value);
      if (error != null) return error;
    }

    return null;
  }
}
