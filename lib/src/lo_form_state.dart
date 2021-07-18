import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

typedef ValMap = Map<String, dynamic>;
typedef ErrMap = Map<String, String?>;
typedef ValToErrFunc = Future<ErrMap?> Function(ValMap);

class LoFormState extends ChangeNotifier {
  final ValMap? initialValues;
  final ValMap values;
  final ErrMap errors;
  final ValToErrFunc? validate;
  final ValToErrFunc onSubmit;

  LoFormStatus status;

  LoFormState({
    this.initialValues,
    required this.onSubmit,
    this.validate,
  })  : values = {},
        errors = {},
        status = LoFormStatus.pure;

  void registerField(String name) {
    if (values.containsKey(name)) return; // Prevent re-registration
    values[name] = initialValues?[name];
    errors[name] = null;
  }

  Future<void> updateField<T>(String name, T value, [String? error]) async {
    values[name] = value;
    errors[name] = error;

    // Check form-level errors only if the field has no errors itself
    if (error == null) {
      final formLevelErrors = await validate?.call(values);
      errors[name] = formLevelErrors?[name];
    }

    final hasErrors = errors.entries.any((f) => f.value != null);
    status = hasErrors ? LoFormStatus.invalid : LoFormStatus.valid;

    notifyListeners();
  }

  Future<void> submit() async {
    status = LoFormStatus.loading;
    notifyListeners();

    final submitErrors = await onSubmit(values);
    errors.forEach((name, value) {
      errors[name] = submitErrors?[name] ?? value;
    });

    final hasErrors = submitErrors?.isNotEmpty ?? false;
    status = hasErrors ? LoFormStatus.invalid : LoFormStatus.submitted;
    notifyListeners();
  }
}
