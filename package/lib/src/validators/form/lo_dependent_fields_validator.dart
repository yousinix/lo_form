import '../../../core.dart';

class LoDependentFieldsValidator<TKey> extends LoFormBaseValidator<TKey> {
  final List<TKey> fields;
  final String Function(Map<TKey, dynamic>) validateFunc;

  LoDependentFieldsValidator({
    required this.fields,
    required this.validateFunc,
  });

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) {
    final fieldValues = <TKey, dynamic>{};
    for (final field in fields) {
      fieldValues[field] = values.get(field);
    }

    final error = validateFunc(fieldValues);
    return error.isNotEmpty ? {fields.first: error} : null;
  }
}
