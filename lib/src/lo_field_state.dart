import 'package:flutter/foundation.dart';

class LoFieldState<T> {
  final String name;
  final T? initialValue;
  final String? error;
  final ValueChanged<T> onChanged;

  const LoFieldState({
    required this.name,
    this.initialValue,
    this.error,
    required this.onChanged,
  });
}
