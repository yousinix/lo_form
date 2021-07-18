enum LoFormStatus {
  pure,
  loading,
  valid,
  invalid,
  submitted,
}

extension LoFormStatusX on LoFormStatus {
  bool get isPure => this == LoFormStatus.pure;
  bool get isLoading => this == LoFormStatus.loading;
  bool get isValid => this == LoFormStatus.valid;
  bool get isInvalid => this == LoFormStatus.invalid;
  bool get isSubmitted => this == LoFormStatus.submitted;
}
