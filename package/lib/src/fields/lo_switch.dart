import 'package:flutter/material.dart';
import '../../core.dart';

class LoSwitch extends StatelessWidget {
  final String loKey;
  final bool? initialValue;
  final List<LoFieldBaseValidator<bool>>? validators;
  final Duration? debounceTime;
  final String label;

  const LoSwitch({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, bool>(
      loKey: loKey,
      initialValue: initialValue ?? false,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text(label),
            value: state.value ?? false,
            onChanged: state.onChanged,
          ),
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                state.error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }
}
