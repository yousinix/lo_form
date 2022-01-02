import '../../src/lo_form_base_validator.dart';
import '../../src/types.dart';

class LoMatchValidator extends LoFormBaseValidator {
  final String message;

  /// The name of the [master] field
  final String master;

  /// The name of the [slave] field, it will contain the error
  /// if does not match [master].
  final String slave;

  LoMatchValidator(
    this.master,
    this.slave, [
    this.message = 'Does not match',
  ]);

  @override
  ErrMap? validate(ValMap values) {
    final masterValue = values.get(master);
    final slaveValue = values.get(slave);

    if (masterValue != slaveValue) {
      return {slave: message};
    } else if (masterValue != null && slaveValue != null) {
      return {slave: null}; // Clear error
    }
  }
}
