import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';
import 'types.dart';

class LoFieldState<T> {
  final String name;
  final T? initialValue;
  final ValueChanged<T> onChanged;
  final FieldValidateFunc<T>? validate;
  LoFormStatus status;
  bool touched;
  T? value;
  String? error;

  LoFieldState({
    required this.name,
    this.initialValue,
    required this.onChanged,
    required this.validate,
    required this.status,
    required this.touched,
    this.value,
    this.error,
  });
}
