import '../src/lo_validator.dart';

class LoCustomValidator<T> implements LoValidator<T> {
  final String? Function(T?) validateFunction;

  LoCustomValidator(this.validateFunction);

  @override
  String? validate(T? value) => validateFunction(value);
}
