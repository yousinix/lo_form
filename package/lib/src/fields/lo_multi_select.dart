import 'package:flutter/material.dart';
import '../../core.dart';

class LoMultiSelect<T> extends StatelessWidget {
  final String loKey;
  final List<T>? initialValue;
  final List<LoFieldBaseValidator<List<T>>>? validators;
  final Duration? debounceTime;
  final List<MultiSelectOption<T>> options;

  const LoMultiSelect({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, List<T>>(
      loKey: loKey,
      initialValue: initialValue ?? [],
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...options.map((option) => CheckboxListTile(
                title: Text(option.label),
                value: state.value?.contains(option.value) ?? false,
                onChanged: (bool? value) {
                  final newValue = List<T>.from(state.value ?? []);
                  if (value == true) {
                    newValue.add(option.value);
                  } else {
                    newValue.remove(option.value);
                  }
                  state.onChanged(newValue);
                },
              )),
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

class MultiSelectOption<T> {
  final String label;
  final T value;

  MultiSelectOption({required this.label, required this.value});
}
