import '../../src/lo_form_base_validator.dart';
import '../../src/types.dart';

class LoFormValidator extends LoFormBaseValidator {
  final ErrMap? Function(ValMap) validateFunction;

  LoFormValidator(this.validateFunction);

  @override
  ErrMap? validate(ValMap values) => validateFunction(values);
}
