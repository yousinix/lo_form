import '../../../core.dart';

class LoFieldValidator<T> implements LoFieldBaseValidator<T> {
  final ValidateFunc<T?, String> validateImpl;

  LoFieldValidator(this.validateImpl);

  /// {@template LoValidator.all}
  LoFieldValidator.all(
    List<LoFieldBaseValidator<T>> validators,
  ) : validateImpl = LoValidator.all<T?, String?>(validators);

  /// {@template LoValidator.any}
  LoFieldValidator.any(
    List<LoFieldBaseValidator<T>> validators,
  ) : validateImpl = LoValidator.any<T?, String?>(validators);

  @override
  String? validate(T? value) => validateImpl(value);
}
