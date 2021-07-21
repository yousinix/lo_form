import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

typedef ValMap = Map<String, dynamic>;
typedef ErrMap = Map<String, String?>;
typedef StsMap = Map<String, LoFormStatus>;
typedef TchMap = Map<String, bool>;
typedef ValidateFunc = ErrMap? Function(ValMap);
typedef SubmitFunc = Future<ErrMap?> Function(ValMap);

extension ValMapX on ValMap {
  /// Shorthand for using "as" to cast the dynamic value
  T get<T>(String key) => this[key] as T;
}

class LoFormState extends ChangeNotifier {
  final ValMap? initialValues;
  final ValMap values;
  final ErrMap errors;
  final StsMap statuses;
  final TchMap touched;
  final ValidateFunc? validate;
  final SubmitFunc onSubmit;
  final ValueChanged<LoFormState>? onChanged;

  LoFormStatus status;

  LoFormState({
    this.initialValues,
    required this.onSubmit,
    this.onChanged,
    this.validate,
  })  : values = {},
        errors = {},
        statuses = {},
        touched = {},
        status = LoFormStatus.pure;

  /// Gets field value
  T get<T>(String key) => values[key] as T;

  void registerField(String name) {
    if (values.containsKey(name)) return; // Prevent re-registration
    values[name] = initialValues?[name];
    errors[name] = null;
    statuses[name] = LoFormStatus.pure;
    touched[name] = false;
  }

  void _notifyChanged() {
    onChanged?.call(this);
    notifyListeners();
  }

  void markTouched(String name) {
    if (touched[name]!) return;
    touched[name] = true;
    _notifyChanged();
  }

  void updateField<T>(String name, T value, [String? error]) {
    values[name] = value;
    touched[name] = true;

    // Check form-level errors only if the field has no errors itself
    errors[name] = error ?? validate?.call(values)?[name];

    if (errors[name] != null) {
      statuses[name] = LoFormStatus.invalid;
    } else if (value == initialValues?[name]) {
      statuses[name] = LoFormStatus.pure;
    } else {
      statuses[name] = LoFormStatus.valid;
    }

    status = statuses.values.reduce((res, x) => res.and(x));
    _notifyChanged();
  }

  Future<void> submit() async {
    status = LoFormStatus.loading;
    _notifyChanged();

    final submitErrors = await onSubmit(values);
    errors.forEach((name, value) {
      if (submitErrors?[name] != null) {
        errors[name] = submitErrors?[name];
        statuses[name] = LoFormStatus.invalid;
      }
    });

    final hasErrors = submitErrors?.isNotEmpty ?? false;
    status = hasErrors ? LoFormStatus.invalid : LoFormStatus.submitted;
    _notifyChanged();
  }
}
