enum LoFormStatus {
  /// All fields have their initial values.
  pure,

  /// All fields have valid values.
  valid,

  /// Some fields have invalid values.
  invalid,

  /// All fields are either valid or pure, but not invalid.
  mixed,

  /// Submission is in progress.
  loading,

  /// Submission has finished with success.
  success,

  /// Submission has finished with failure.
  failure,
}

extension LoFormStatusX on LoFormStatus {
  bool get isPure => this == LoFormStatus.pure;

  bool get isValid => this == LoFormStatus.valid;

  bool get isInvalid => this == LoFormStatus.invalid;

  bool get isMixed => this == LoFormStatus.mixed;

  bool get isLoading => this == LoFormStatus.loading;

  bool get isSuccess => this == LoFormStatus.success;

  bool get isFailure => this == LoFormStatus.failure;

  bool get isSubmitted => isSuccess || isFailure;

  /// Behaves like the logical and operator but for [LoFormStatus]
  ///
  /// | X         | Y         | Result    |
  /// | :-------- | :-------- | :-------- |
  /// | `invalid` | `any`     | `invalid` |
  /// | `pure`    | `pure`    | `pure`    |
  /// | `valid`   | `valid`   | `valid`   |
  /// | `pure`    | `valid`   | `mixed`   |
  /// | `valid`   | `pure`    | `mixed`   |
  LoFormStatus and(LoFormStatus other) {
    if (isInvalid || other.isInvalid) return LoFormStatus.invalid;
    if (isPure && other.isPure) return LoFormStatus.pure;
    if (isValid && other.isValid) return LoFormStatus.valid;
    return LoFormStatus.mixed;
  }
}
