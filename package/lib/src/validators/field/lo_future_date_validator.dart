import '../../../core.dart';

class LoFutureDateValidator implements LoFieldBaseValidator<DateTime> {
  final String message;
  final bool includeToday;

  LoFutureDateValidator({
    this.message = 'Date must be in the future',
    this.includeToday = false,
  });

  @override
  String? validate(DateTime? value) {
    if (value == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (includeToday) {
      return value.isBefore(today) ? message : null;
    } else {
      return value.isBefore(now) ? message : null;
    }
  }
}
