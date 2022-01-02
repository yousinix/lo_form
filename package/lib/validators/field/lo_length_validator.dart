import '../../src/lo_field_base_validator.dart';

class LoLengthValidator implements LoFieldBaseValidator<String> {
  final String message;

  /// String's length must be more than or equal [min].
  final int? min;

  /// String's length must be less than or equal [max].
  final int? max;

  LoLengthValidator(
    this.min,
    this.max,
  ) : message = 'Must be between $min and $max characters';

  LoLengthValidator.exact(int length)
      : message = 'Must be $length characters',
        min = length,
        max = length;

  LoLengthValidator.min(this.min)
      : message = 'Must be $min or more characters',
        max = null;

  LoLengthValidator.max(this.max)
      : message = 'Must be $max or less characters',
        min = null;

  @override
  String? validate(String? value) {
    if (value == null) return null;
    if (min != null && value.length < min!) return message;
    if (max != null && value.length > max!) return message;
  }
}
