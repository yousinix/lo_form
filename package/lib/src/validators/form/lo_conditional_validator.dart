import '../../../core.dart';

class LoConditionalValidator<TKey> extends LoFormBaseValidator<TKey> {
  final TKey conditionField;
  final bool Function(dynamic) condition;
  final Map<TKey, LoFieldBaseValidator> validatorsIfTrue;
  final Map<TKey, LoFieldBaseValidator> validatorsIfFalse;

  LoConditionalValidator({
    required this.conditionField,
    required this.condition,
    required this.validatorsIfTrue,
    this.validatorsIfFalse = const {},
  });

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) {
    final conditionValue = values.get(conditionField);
    final isConditionMet = condition(conditionValue);

    final errors = <TKey, String>{};

    final validatorsToApply =
        isConditionMet ? validatorsIfTrue : validatorsIfFalse;

    for (final entry in validatorsToApply.entries) {
      final fieldKey = entry.key;
      final validator = entry.value;
      final fieldValue = values.get(fieldKey);
      final error = validator.validate(fieldValue);
      if (error != null) {
        errors[fieldKey] = error;
      }
    }

    return errors.isEmpty ? null : errors;
  }
}
