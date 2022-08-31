import '../../../core.dart';

/// Validates that the given value is not null or empty.
class LoRequiredValidator<T> implements LoFieldBaseValidator<T> {
  final String message;

  /// Validates that the given value is not "empty",
  /// which is relative to [T], the empty values for primitive types are:
  /// - `num`: 0
  /// - `bool`: false
  /// - `String`: ''
  final bool validateEmpty;

  LoRequiredValidator([
    this.message = 'Required',
  ]) : validateEmpty = true;

  LoRequiredValidator.nullOnly([
    this.message = 'Required',
  ]) : validateEmpty = false;

  @override
  String? validate(T? value) {
    if (value == null) return message;
    if (!validateEmpty) return null;
    if (value is num) return value == 0 ? message : null;
    if (value is bool) return !value ? message : null;
    if (value is String) return value.isEmpty ? message : null;
    return null;
  }
}
