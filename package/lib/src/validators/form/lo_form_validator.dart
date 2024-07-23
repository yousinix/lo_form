import '../../../core.dart';

class LoFormValidator<TKey> extends LoFormBaseValidator<TKey> {
  final ValidateFunc<ValMap<TKey>, ErrMap<TKey>> validateImpl;

  LoFormValidator(this.validateImpl);

  /// {@template LoValidator.all}
  /// {@endtemplate}
  LoFormValidator.all(
    List<LoFormBaseValidator<TKey>> validators, [
    ErrMap<TKey>? errors,
  ]) : validateImpl = LoValidator.all<ValMap<TKey>, ErrMap<TKey>?>(
          validators,
          errors,
        );

  /// {@template LoValidator.any}
  /// {@endtemplate}
  LoFormValidator.any(
    List<LoFormBaseValidator<TKey>> validators, [
    ErrMap<TKey>? errors,
  ]) : validateImpl = LoValidator.any<ValMap<TKey>, ErrMap<TKey>?>(
          validators,
          errors,
        );

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) => validateImpl(values);
}
