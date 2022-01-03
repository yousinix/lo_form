import '../../../core.dart';

class LoFieldValidator<T> implements LoFieldBaseValidator<T> {
  final String? Function(T?) validateFunction;

  LoFieldValidator(this.validateFunction);

  @override
  String? validate(T? value) => validateFunction(value);
}
