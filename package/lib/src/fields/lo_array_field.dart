import 'package:flutter/material.dart';

import '../../core.dart';

class LoArrayField<TValue> extends StatelessWidget {
  final String loKey;
  final List<TValue>? initialValue;
  final List<LoFieldBaseValidator<List<TValue>>>? validators;
  final Duration? debounceTime;
  final List<Widget> Function(
    BuildContext,
    List<TValue>? value,
    ValueChanged<List<TValue>> onChanged,
  ) buildFields;

  const LoArrayField({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.buildFields,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, List<TValue>>(
      loKey: loKey,
      initialValue: initialValue ?? [],
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) {
        return Column(
          children: [
            ...buildFields(
              context,
              state.value,
              state.onChanged,
            ),
            Text(
              state.error ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
