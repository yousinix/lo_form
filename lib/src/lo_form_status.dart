enum LoFormStatus {
  pure,
  loading,
  idle,
}

extension LoFormStatusX on LoFormStatus {
  bool get isPure => this == LoFormStatus.pure;
  bool get isLoading => this == LoFormStatus.loading;
  bool get isIdle => this == LoFormStatus.idle;
}
