import 'package:flutter/material.dart' show DateTimeRange;

import '../../../core.dart';

class LoDateRangeValidator implements LoFieldBaseValidator<DateTimeRange> {
  final String message;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Duration? maxDuration;

  LoDateRangeValidator({
    this.message = 'Invalid date range',
    this.minDate,
    this.maxDate,
    this.maxDuration,
  });

  @override
  String? validate(DateTimeRange? value) {
    if (value == null) return null;
    if (minDate != null && value.start.isBefore(minDate!)) {
      return 'Start date must be after ${_formatDate(minDate!)}';
    }
    if (maxDate != null && value.end.isAfter(maxDate!)) {
      return 'End date must be before ${_formatDate(maxDate!)}';
    }
    if (maxDuration != null && value.duration > maxDuration!) {
      return 'Date range cannot exceed ${maxDuration!.inDays} days';
    }
    return null;
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
