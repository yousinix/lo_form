import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_state.dart';
import 'lo_form_state.dart';

class LoField<T> extends StatelessWidget {
  final String name;
  final Widget Function(LoFieldState<T>) builder;

  const LoField({
    Key? key,
    required this.name,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LoFormState>().registerField(name);

    return Consumer<LoFormState>(
      builder: (_, formState, __) {
        final fieldState = LoFieldState<T>(
          name: name,
          initialValue: formState.initialValues?[name] as T,
          onChanged: (value) => formState.updateField(name, value),
        );

        return builder(fieldState);
      },
    );
  }
}
