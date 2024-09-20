import '../../../core.dart';

class LoUniqueFieldsValidator<TKey> extends LoFormBaseValidator<TKey> {
  final List<TKey> fields;
  final String message;

  LoUniqueFieldsValidator({
    required this.fields,
    this.message = 'Fields must have unique values',
  });

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) {
    final fieldValues = fields.map((field) => values.get(field)).toList();
    final uniqueValues = fieldValues.toSet();

    if (uniqueValues.length != fieldValues.length) {
      return {fields.first: message};
    }

    return null;
  }
}
