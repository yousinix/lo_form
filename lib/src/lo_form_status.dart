enum LoFormStatus {
  pure,
  loading,
  valid,
  invalid,
  submitted,
  unknown,
}

extension LoFormStatusX on LoFormStatus {
  bool get isPure => this == LoFormStatus.pure;
  bool get isLoading => this == LoFormStatus.loading;
  bool get isValid => this == LoFormStatus.valid;
  bool get isInvalid => this == LoFormStatus.invalid;
  bool get isSubmitted => this == LoFormStatus.submitted;

  LoFormStatus and(LoFormStatus other) {
    if (isInvalid || other.isInvalid) return LoFormStatus.invalid;
    if (isPure && other.isPure) return LoFormStatus.pure;
    if (isValid || other.isValid) return LoFormStatus.valid;
    return LoFormStatus.unknown;
  }
}
