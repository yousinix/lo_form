import 'lo_form_status.dart';

enum LoFieldStatus {
  /// Has its initial value.
  pure,

  /// The current value is valid.
  valid,

  /// The current value is invalid.
  invalid,
}

extension LoFieldStatusX on LoFieldStatus {
  bool get isPure => this == LoFieldStatus.pure;

  bool get isValid => this == LoFieldStatus.valid;

  bool get isInvalid => this == LoFieldStatus.invalid;

  /// Transforms [LoFieldStatus] to [LoFormStatus].
  LoFormStatus toFormStatus() {
    if (isPure) return LoFormStatus.pure;
    if (isValid) return LoFormStatus.valid;
    return LoFormStatus.invalid;
  }
}
