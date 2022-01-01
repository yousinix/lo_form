import '../src/lo_validator.dart';

class LoRegExpValidator implements LoValidator<String> {
  final String message;
  final String pattern;

  LoRegExpValidator(this.pattern, [this.message = 'Does not match']);

  LoRegExpValidator.email([this.message = 'Invalid email format'])
      : pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|'
            r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.'
            r'[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  String? validate(String? value) {
    final regex = RegExp(pattern);
    return !regex.hasMatch(value ?? '') ? message : null;
  }
}
