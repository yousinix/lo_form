import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

class LoFieldState<T> {
  final String name;
  final LoFormStatus status;
  final T? initialValue;
  final String? error;
  final ValueChanged<T> onChanged;

  const LoFieldState({
    required this.name,
    required this.status,
    this.initialValue,
    this.error,
    required this.onChanged,
  });
}
