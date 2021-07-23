enum LoFormStatus {
  pure,
  valid,
  invalid,
  mixed, // Valid and Pure
  loading,
  success,
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

  LoFormStatus and(LoFormStatus other) {
    if (isInvalid || other.isInvalid) return LoFormStatus.invalid;
    if (isPure && other.isPure) return LoFormStatus.pure;
    if (isValid && other.isValid) return LoFormStatus.valid;
    return LoFormStatus.mixed;
  }
}
