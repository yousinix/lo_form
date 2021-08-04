import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_state.dart';
import 'lo_form_state.dart';
import 'lo_form_status.dart';
import 'types.dart';

class LoField<T> extends StatefulWidget {
  final String name;
  final T? initialValue;
  final Widget Function(LoFieldState<T>) builder;
  final FieldValidateFunc<T>? validate;

  const LoField({
    Key? key,
    required this.name,
    this.initialValue,
    required this.builder,
    this.validate,
  }) : super(key: key);

  @override
  _LoFieldState<T> createState() => _LoFieldState<T>();
}

class _LoFieldState<T> extends State<LoField<T>> {
  @override
  void initState() {
    super.initState();
    context.read<LoFormState>().registerField(
          name: widget.name,
          initialValue: widget.initialValue,
          validate: widget.validate,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoFormState>(
      builder: (_, form, __) {
        final field = form.fields.get<T>(widget.name);

        return FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              if (focus) {
                form.markTouched<T>(widget.name);
              } else if (field.status.isPure) {
                // Validate pure fields when unfocused
                final value = form.get<T>(widget.name);
                form.updateField<T>(widget.name, value);
              }
            },
            child: widget.builder(field),
          ),
        );
      },
    );
  }
}
