import '../../../core.dart';

class LoFormValidator<TKey> extends LoFormBaseValidator<TKey> {
  final ValidateFunc<ValMap<TKey>, ErrMap<TKey>> validateImpl;

  LoFormValidator(this.validateImpl);

  /// {@template LoValidator.all}
  LoFormValidator.all(
    List<LoFormBaseValidator<TKey>> validators,
  ) : validateImpl = LoValidator.all<ValMap<TKey>, ErrMap<TKey>?>(validators);

  /// {@template LoValidator.any}
  LoFormValidator.any(
    List<LoFormBaseValidator<TKey>> validators,
  ) : validateImpl = LoValidator.any<ValMap<TKey>, ErrMap<TKey>?>(validators);

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) => validateImpl(values);
}
