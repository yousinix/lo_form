import 'package:flutter/foundation.dart';

class LoFormState extends ChangeNotifier {
  final void Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic> values;

  LoFormState({
    required this.onSubmit,
  }) : values = {};

  void registerField(String name) {
    if (values.containsKey(name)) return;
    values[name] = null;
  }

  void updateField<T>(String name, T value) {
    values[name] = value;
    notifyListeners();
  }

  void submit() {
    onSubmit(values);
  }
}
