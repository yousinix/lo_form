/// Used to indicate both Fields and Forms statuses.
enum LoStatus {
  /// - Form: all fields have their initial values.
  /// - Field: has its initial value.
  pure,

  /// - Form: all fields have valid values.
  /// - Field: the current value is valid.
  valid,

  /// - Form: all fields have valid values.
  /// - Field: the current value is valid.
  invalid,

  /// - Form: all fields are either valid or pure, but not invalid.
  mixed,

  /// - Form: submission is in progress.
  loading,

  /// - Form: submission has finished with success.
  success,

  /// - Form: submission has finished with failure.
  failure,
}

extension LoStatusX on LoStatus {
  bool get isPure => this == LoStatus.pure;

  bool get isValid => this == LoStatus.valid;

  bool get isInvalid => this == LoStatus.invalid;

  bool get isMixed => this == LoStatus.mixed;

  bool get isLoading => this == LoStatus.loading;

  bool get isSuccess => this == LoStatus.success;

  bool get isFailure => this == LoStatus.failure;

  bool get isSubmitted => isSuccess || isFailure;

  /// Behaves like the logical and operator but for [LoStatus]
  /// to accumulate field statuses to compute the form status.
  ///
  /// | A       | B       | Result  |
  /// | :------ | :------ | :------ |
  /// | invalid | any     | invalid |
  /// | pure    | pure    | pure    |
  /// | valid   | valid   | valid   |
  /// | pure    | valid   | mixed   |
  /// | valid   | pure    | mixed   |
  LoStatus and(LoStatus other) {
    if (isInvalid || other.isInvalid) return LoStatus.invalid;
    if (isPure && other.isPure) return LoStatus.pure;
    if (isValid && other.isValid) return LoStatus.valid;
    return LoStatus.mixed;
  }
}
