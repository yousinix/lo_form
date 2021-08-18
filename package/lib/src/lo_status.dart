enum LoStatus {
  pure,
  valid,
  invalid,
  mixed, // Valid and Pure
  loading,
  success,
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

  LoStatus and(LoStatus other) {
    if (isInvalid || other.isInvalid) return LoStatus.invalid;
    if (isPure && other.isPure) return LoStatus.pure;
    if (isValid && other.isValid) return LoStatus.valid;
    return LoStatus.mixed;
  }

}
