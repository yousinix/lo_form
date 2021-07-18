import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_state.dart';
import 'lo_form_state.dart';

class LoField<T> extends StatelessWidget {
  final String name;
  final Widget Function(LoFieldState<T>) builder;
  final String? Function(T)? validate;

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
            onFocusChange: (focus) => state.markTouched(name),
            child: builder(
              LoFieldState<T>(
                name: name,
                status: state.statuses[name]!,
                touched: state.touched[name]!,
                initialValue: state.initialValues?[name] as T,
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
