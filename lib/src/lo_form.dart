import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_form_state.dart';

class LoForm extends StatelessWidget {
  final Map<String, dynamic>? initialValues;
  final Future<Map<String, String>?> Function(Map<String, dynamic>)? validate;
  final Future<void> Function(Map<String, dynamic>) onSubmit;
  final Widget Function(LoFormState) builder;

  const LoForm({
    Key? key,
    this.initialValues,
    this.validate,
    required this.onSubmit,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = LoFormState(
      initialValues: initialValues,
      validate: validate,
      onSubmit: onSubmit,
    );

    return ChangeNotifierProvider(
      create: (_) => state,
      child: Consumer<LoFormState>(
        builder: (_, state, __) => builder(state),
      ),
    );
  }
}
