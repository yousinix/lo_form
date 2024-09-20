import 'package:flutter/material.dart';
import '../../core.dart';

class LoSlider extends StatelessWidget {
  final String loKey;
  final double? initialValue;
  final List<LoFieldBaseValidator<double>>? validators;
  final Duration? debounceTime;
  final double min;
  final double max;
  final int? divisions;
  final String? label;

  const LoSlider({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.min,
    required this.max,
    this.divisions,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, double>(
      loKey: loKey,
      initialValue: initialValue ?? min,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: state.value ?? min,
            min: min,
            max: max,
            divisions: divisions,
            label: label ?? state.value?.toStringAsFixed(2),
            onChanged: state.onChanged,
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
