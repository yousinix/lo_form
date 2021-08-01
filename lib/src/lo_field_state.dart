import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

class LoFieldState<T> {
  final String name;
  final LoFormStatus status;
  final bool touched;
  final T? initialValue;
  final T? value;
  final String? error;
  final ValueChanged<T> onChanged;

  const LoFieldState({
    required this.name,
    required this.status,
    required this.touched,
    this.initialValue,
    this.value,
    this.error,
    required this.onChanged,
  });
}
