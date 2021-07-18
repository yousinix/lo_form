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
  })  : values = initialValues ?? {},
        errors = {},
        isSubmitting = false;

  void registerField(String name) {
    if (values.containsKey(name)) return;
    values[name] = null;
  }

  void updateField<T>(String name, T value) {
    values[name] = value;
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
