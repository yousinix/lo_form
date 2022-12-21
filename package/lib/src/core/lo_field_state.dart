import 'package:flutter/foundation.dart';

import 'debouncer.dart';
import 'lo_field_base_validator.dart';
import 'lo_field_status.dart';

class LoFieldState<TKey, TValue> {
  LoFieldState({
    required this.loKey,
    this.initialValue,
    this.validators = const [],
    required ValueChanged<TValue> onChanged,
    this.debounceTime,
  })  : _onValueChanged = onChanged,
        _debouncer = debounceTime == null ? null : Debouncer(debounceTime),
        value = initialValue,
        touched = false,
        error = null;

  /// {@template LoFieldState.loKey}
  /// Unique key for this across the form.
  /// {@endtemplate}
  final TKey loKey;

  /// Function that should be called with every change
  /// to update the state accordingly.
  final ValueChanged<TValue> _onValueChanged;

  /// {@template LoFieldState.debounceTime}
  /// The [Duration] used to debounce changes.
  ///
  /// See also:
  ///
  /// - [LoConfig.debounceTimes], a way to set a default debounce time
  ///   for a sepecefic field type.
  /// {@endtemplate}
  final Duration? debounceTime;

  /// A timer responsible for depouncing changes.
  final Debouncer? _debouncer;

  /// {@template LoFieldState.validators}
  /// List of the validators to run on each change.
  ///
  /// See also:
  ///
  /// - [LoFieldBaseValidator], used for validation.
  /// {@endtemplate}
  final List<LoFieldBaseValidator<TValue>> validators;

  /// {@template LoFieldState.initialValue}
  /// The initial value that makes [LoFieldState.status] pure.
  /// {@endtemplate}
  final TValue? initialValue;

  /// An indicator whether the field has been focused or not.
  bool touched;

  /// The current value, initialized as [initialValue].
  TValue? value;

  /// The current error message.
  String? error;

  /// Function that should be called with every change
  /// to update the state accordingly.
  ValueChanged<TValue> get onChanged {
    return _debouncer == null
        ? _onValueChanged
        : (v) => _debouncer?.run(() => _onValueChanged(v));
  }

  /// The current field status:
  ///
  /// * [LoFieldStatus.pure], if the [value] equals [initialValue].
  /// * [LoFieldStatus.valid], if the [error] is null.
  /// * [LoFieldStatus.invalid], if the [error] is not null.
  LoFieldStatus get status {
    if (error != null) {
      return LoFieldStatus.invalid;
    } else if (value == initialValue) {
      return LoFieldStatus.pure;
    } else {
      return LoFieldStatus.valid;
    }
  }

  void dispose() {
    _debouncer?.dispose();
  }
}
