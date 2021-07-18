import 'package:flutter/foundation.dart';

class LoFormState extends ChangeNotifier {
  final Map<String, dynamic>? initialValues;
  final Map<String, dynamic> values;
  final Map<String, String> errors;
  final Future<void> Function(Map<String, dynamic>) onSubmit;

  bool isSubmitting;

  LoFormState({
    this.initialValues,
    required this.onSubmit,
  })  : values = {},
        errors = {},
        isSubmitting = false;

  void registerField(String name) {
    if (values.containsKey(name)) return;
    values[name] = initialValues?[name];
  }

  void updateField<T>(String name, T value, [String? error]) {
    values[name] = value;

    if (error == null) {
      errors.remove(name);
    } else {
      errors[name] = error;
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
