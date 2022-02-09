import '../../../core.dart';

class LoFieldValidator<T> implements LoFieldBaseValidator<T> {
  final ValidateFunc<T?, String> validateImpl;

  LoFieldValidator(this.validateImpl);

  /// {@template LoValidator.all}
  LoFieldValidator.all(
    List<LoFieldBaseValidator<T>> validators, [
    String? message,
  ]) : validateImpl = LoValidator.all<T?, String?>(
          validators,
          message,
        );

  /// {@template LoValidator.any}
  LoFieldValidator.any(
    List<LoFieldBaseValidator<T>> validators, [
    String? message,
  ]) : validateImpl = LoValidator.any<T?, String?>(
          validators,
          message,
        );

  @override
  String? validate(T? value) => validateImpl(value);
}
