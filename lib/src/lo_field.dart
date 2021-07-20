import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_state.dart';
import 'lo_form_state.dart';
import 'lo_form_status.dart';

typedef FieldValidateFunc<T> = String? Function(T?);

class LoField<T> extends StatelessWidget {
  final String name;
  final Widget Function(LoFieldState<T>) builder;
  final FieldValidateFunc<T>? validate;

  const LoField({
    Key? key,
    required this.name,
    required this.builder,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoFormState>(
      builder: (_, state, __) {
        state.registerField(name);

        return FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              if (focus) {
                state.markTouched(name);
              } else if (state.statuses[name]!.isPure) {
                // Validate pure fields when unfocused
                final value = state.values[name] as T?;
                final error = validate?.call(value);
                state.updateField(name, value, error);
              }
            },
            child: builder(
              LoFieldState<T>(
                name: name,
                status: state.statuses[name]!,
                touched: state.touched[name]!,
                initialValue: state.initialValues?[name] as T?,
                error: state.errors[name],
                onChanged: (value) {
                  final error = validate?.call(value);
                  state.updateField(name, value, error);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
