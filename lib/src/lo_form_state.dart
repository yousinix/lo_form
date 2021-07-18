import 'package:flutter/foundation.dart';

import 'lo_form_status.dart';

typedef ValMap = Map<String, dynamic>;
typedef ErrMap = Map<String, String>;
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
    if (values.containsKey(name)) return;
    values[name] = initialValues?[name];
  }

  Future<void> updateField<T>(String name, T value, [String? error]) async {
    values[name] = value;

    if (error != null) {
      errors[name] = error;
    } else {
      final formLevelErrors = await validate?.call(values);
      final secondaryError = formLevelErrors?[name];

      if (secondaryError != null) {
        errors[name] = secondaryError;
      } else {
        errors.remove(name);
      }
    }

    notifyListeners();
  }


  Future<void> submit() async {
    status = LoFormStatus.loading;
    notifyListeners();

    errors.clear();
    final submitErrors = await onSubmit(values);
    if (submitErrors != null) errors.addAll(submitErrors);

    status = LoFormStatus.idle;
    notifyListeners();
  }
}
