import '../../../core.dart';

class LoFormValidator extends LoFormBaseValidator {
  final ErrMap? Function(ValMap) validateFunction;

  LoFormValidator(this.validateFunction);

  @override
  ErrMap? validate(ValMap values) => validateFunction(values);
}
