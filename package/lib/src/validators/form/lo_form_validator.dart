import '../../../core.dart';

class LoFormValidator<TKey> extends LoFormBaseValidator<TKey> {
  final ErrMap<TKey>? Function(ValMap<TKey>) validateFunction;

  LoFormValidator(this.validateFunction);

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) => validateFunction(values);
}
