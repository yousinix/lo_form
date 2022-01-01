import 'package:flutter/foundation.dart';

import 'debouncer.dart';
import 'lo_status.dart';
import 'lo_validator.dart';

class LoFieldState<T> {
  LoFieldState({
    required this.name,
    this.initialValue,
    this.validators,
    required ValueChanged<T> onChanged,
    this.debounceTime,
  })  : _onValueChanged = onChanged,
        _debouncer = debounceTime == null ? null : Debouncer(debounceTime),
        value = initialValue,
        touched = false,
        error = null;

  /// {@template LoFieldState.name}
  /// Unique name for this across the form.
  /// {@endtemplate}
  final String name;

  /// Function that should be called with every change
  /// to update the state accordingly.
  final ValueChanged<T> _onValueChanged;

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
  /// - [LoValidator], used for validation.
  /// {@endtemplate}
  final List<LoValidator<T>>? validators;

  /// {@template LoFieldState.initialValue}
  /// The initial value that makes [status] pure.
  /// {@endtemplate}
  final T? initialValue;

  /// An indicator whether the field has been focused or not.
  bool touched;

  /// The current value, initialized as [initialValue].
  T? value;

  /// The current error message.
  String? error;

  /// Function that should be called with every change
  /// to update the state accordingly.
  ValueChanged<T> get onChanged {
    return _debouncer == null
        ? _onValueChanged
        : (v) => _debouncer?.run(() => _onValueChanged(v));
  }

  /// The current field status:
  ///
  /// * [LoStatus.pure], if the [value] equals [initialValue].
  /// * [LoStatus.valid], if the [error] is null.
  /// * [LoStatus.invalid], if the [error] is not null.
  LoStatus get status {
    if (error != null) {
      return LoStatus.invalid;
    } else if (value == initialValue) {
      return LoStatus.pure;
    } else {
      return LoStatus.valid;
    }
  }

  void dispose() {
    _debouncer?.dispose();
  }
}
