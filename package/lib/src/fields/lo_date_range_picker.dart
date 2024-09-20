import 'package:flutter/material.dart';
import '../../core.dart';

class LoDateRangePicker extends StatelessWidget {
  final String loKey;
  final DateTimeRange? initialValue;
  final List<LoFieldBaseValidator<DateTimeRange>>? validators;
  final Duration? debounceTime;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const LoDateRangePicker({
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
    return LoField<String, DateTimeRange>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => InkWell(
        onTap: () async {
          final DateTimeRange? picked = await showDateRangePicker(
            context: context,
            initialDateRange: state.value,
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ?? DateTime(2100),
          );
          if (picked != null) {
            state.onChanged(picked);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Select Date Range',
            errorText: state.error,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.value != null
                    ? '${_formatDate(state.value!.start)} - ${_formatDate(state.value!.end)}'
                    : 'No date range selected',
              ),
              const Icon(Icons.date_range),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
