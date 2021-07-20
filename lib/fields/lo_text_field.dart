import 'package:flutter/material.dart';

import '../src/lo_field.dart';

class LoTextField extends StatelessWidget {
  final String name;
  final FieldValidateFunc<String> validate;

  // TODO: add [TextField] fields

  const LoTextField({
    Key? key,
    required this.name,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoField<String>(
      name: name,
      validate: validate,
      builder: (fieldState) => TextFormField(
        initialValue: fieldState.initialValue,
        onChanged: fieldState.onChanged,
        decoration: InputDecoration(
          hintText: name,
          errorText: fieldState.error,
        ),
      ),
    );
  }
}
