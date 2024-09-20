import 'package:flutter/material.dart';
import '../../core.dart';

class LoDatePicker extends StatelessWidget {
  final String loKey;
  final DateTime? initialValue;
  final List<LoFieldBaseValidator<DateTime>>? validators;
  final Duration? debounceTime;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const LoDatePicker({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, DateTime>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: state.value ?? DateTime.now(),
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ?? DateTime(2100),
          );
          if (picked != null) {
            state.onChanged(picked);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Select Date',
            errorText: state.error,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state.value?.toString().split(' ')[0] ?? 'No date selected'),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
