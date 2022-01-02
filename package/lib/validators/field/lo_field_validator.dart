import '../../src/lo_field_base_validator.dart';

class LoFieldValidator<T> implements LoFieldBaseValidator<T> {
  final String? Function(T?) validateFunction;

  LoFieldValidator(this.validateFunction);

  @override
  String? validate(T? value) => validateFunction(value);
}
