import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

typedef ValMap = Map<String, dynamic>;
typedef ErrMap = Map<String, String?>;
typedef StsMap = Map<String, LoFormStatus>;
typedef ValidateFunc = ErrMap? Function(ValMap);
typedef SubmitFunc = Future<ErrMap?> Function(ValMap);

class LoFormState extends ChangeNotifier {
  final ValMap? initialValues;
  final ValMap values;
  final ErrMap errors;
  final StsMap statuses;
  final ValidateFunc? validate;
  final SubmitFunc onSubmit;

  LoFormStatus status;

  LoFormState({
    this.initialValues,
    required this.onSubmit,
    this.validate,
  })  : values = {},
        errors = {},
        statuses = {},
        status = LoFormStatus.pure;

  void registerField(String name) {
    if (values.containsKey(name)) return; // Prevent re-registration
    values[name] = initialValues?[name];
    errors[name] = null;
    statuses[name] = LoFormStatus.pure;
  }

  void updateField<T>(String name, T value, [String? error]) {
    values[name] = value;

    // Check form-level errors only if the field has no errors itself
    errors[name] = error ?? validate?.call(values)?[name];

    if (value == initialValues?[name]) {
      statuses[name] = LoFormStatus.pure;
    } else if (errors[name] != null) {
      statuses[name] = LoFormStatus.invalid;
    } else {
      statuses[name] = LoFormStatus.valid;
    }

    status = statuses.values.reduce((res, x) => res.and(x));
    notifyListeners();
  }

  Future<void> submit() async {
    status = LoFormStatus.loading;
    notifyListeners();

    final submitErrors = await onSubmit(values);
    errors.forEach((name, value) {
      if (submitErrors?[name] != null) {
        errors[name] = submitErrors?[name];
        statuses[name] = LoFormStatus.invalid;
      }
    });

    final hasErrors = submitErrors?.isNotEmpty ?? false;
    status = hasErrors ? LoFormStatus.invalid : LoFormStatus.submitted;
    notifyListeners();
  }
}
