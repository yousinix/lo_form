import 'package:flutter/foundation.dart';

class LoFormState extends ChangeNotifier {
  final Map<String, dynamic>? initialValues;
  final Map<String, dynamic> values;
  final Map<String, String> errors;
  final Future<Map<String, String>?> Function(Map<String, dynamic>)? validate;
  final Future<void> Function(Map<String, dynamic>) onSubmit;

  bool isSubmitting;

  LoFormState({
    this.initialValues,
    required this.onSubmit,
    this.validate,
  })  : values = {},
        errors = {},
        isSubmitting = false;

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
    isSubmitting = true;
    notifyListeners();

    await onSubmit(values);

    isSubmitting = false;
    notifyListeners();
  }
}
