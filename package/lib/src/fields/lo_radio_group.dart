import 'package:flutter/material.dart';
import '../../core.dart';

class LoRadioGroup<T> extends StatelessWidget {
  final String loKey;
  final T? initialValue;
  final List<LoFieldBaseValidator<T>>? validators;
  final List<RadioOption<T>> options;
  final Duration? debounceTime;

  const LoRadioGroup({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    required this.options,
    this.debounceTime,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, T>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...options.map(
            (option) => RadioListTile<T>(
              title: Text(option.label),
              value: option.value,
              groupValue: state.value,
              onChanged: (T? value) => state.onChanged(value as T),
            ),
          ),
          if (state.error != null)
            Text(
              state.error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    );
  }
}

class RadioOption<T> {
  final String label;
  final T value;

  RadioOption({required this.label, required this.value});
}
