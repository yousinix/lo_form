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
    context.read<LoFormState>().registerField(name);

    return Consumer<LoFormState>(
      builder: (_, formState, __) {
        final fieldState = LoFieldState<T>(
          name: name,
          initialValue: formState.initialValues?[name] as T,
          error: formState.errors[name],
          onChanged: (value) {
            final error = validate?.call(value);
            formState.updateField(name, value, error);
          },
        );

        return builder(fieldState);
      },
    );
  }
}
