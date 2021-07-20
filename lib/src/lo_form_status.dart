enum LoFormStatus {
  pure,
  loading,
  valid,
  invalid,
  submitted,
  mixed, // Valid and Pure
}

extension LoFormStatusX on LoFormStatus {
  bool get isPure => this == LoFormStatus.pure;
  bool get isLoading => this == LoFormStatus.loading;
  bool get isValid => this == LoFormStatus.valid;
  bool get isInvalid => this == LoFormStatus.invalid;
  bool get isSubmitted => this == LoFormStatus.submitted;
  bool get isMixed => this == LoFormStatus.mixed;

  LoFormStatus and(LoFormStatus other) {
    if (isInvalid || other.isInvalid) return LoFormStatus.invalid;
    if (isPure && other.isPure) return LoFormStatus.pure;
    if (isValid && other.isValid) return LoFormStatus.valid;
    return LoFormStatus.mixed;
  }
}
