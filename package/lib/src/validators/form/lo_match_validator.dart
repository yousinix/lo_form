import '../../../core.dart';

class LoMatchValidator<TKey> extends LoFormBaseValidator<TKey> {
  final String message;

  /// The loKey of the [master] field
  final TKey master;

  /// The loKey of the [slave] field, it will contain the error
  /// if does not match [master].
  final TKey slave;

  LoMatchValidator(
    this.master,
    this.slave, [
    this.message = 'Does not match',
  ]);

  @override
  ErrMap<TKey>? validate(ValMap<TKey> values) {
    final masterValue = values.get(master);
    final slaveValue = values.get(slave);

    if (masterValue != slaveValue) {
      return {slave: message};
    } else if (masterValue != null && slaveValue != null) {
      return {slave: null}; // Clear error
    }

    return null;
  }
}
