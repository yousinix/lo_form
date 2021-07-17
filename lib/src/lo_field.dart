import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_form_state.dart';

class LoField<T> extends StatelessWidget {
  final String name;
  final Widget Function(T?, void Function(T)) builder;

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
        return builder(
          formState.initialValues?[name] as T ?? null,
          (value) => formState.updateField(name, value),
        );
      },
    );
  }
}
