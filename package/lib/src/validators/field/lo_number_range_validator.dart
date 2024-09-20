import '../../../core.dart';

class LoNumberRangeValidator implements LoFieldBaseValidator<num> {
  final String message;
  final num? min;
  final num? max;
  final bool inclusive;

  LoNumberRangeValidator({
    this.message = 'Number out of range',
    this.min,
    this.max,
    this.inclusive = true,
  });

  @override
  String? validate(num? value) {
    if (value == null) return null;
    if (min != null && (inclusive ? value < min! : value <= min!)) {
      return 'Must be ${inclusive ? 'at least' : 'greater than'} $min';
    }
    if (max != null && (inclusive ? value > max! : value >= max!)) {
      return 'Must be ${inclusive ? 'at most' : 'less than'} $max';
    }
    return null;
  }
}
