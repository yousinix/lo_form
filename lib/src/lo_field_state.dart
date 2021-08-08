import 'package:flutter/foundation.dart';

import 'lo_status.dart';
import 'types.dart';

class LoFieldState<T> {
  final String name;
  final ValueChanged<T> onChanged;
  final FieldValidateFunc<T>? validate;
  final T? initialValue;
  bool touched;
  T? value;
  String? error;

  LoFieldState({
    required this.name,
    required this.onChanged,
    required this.validate,
    this.initialValue,
  })  : touched = false,
        value = initialValue,
        error = null;

  LoStatus get status {
    if (error != null) {
      return LoStatus.invalid;
    } else if (value == initialValue) {
      return LoStatus.pure;
    } else {
      return LoStatus.valid;
    }
  }
}
