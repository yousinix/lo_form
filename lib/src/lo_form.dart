import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_form_state.dart';

class LoForm extends StatelessWidget {
  final ValMap? initialValues;
  final ValToErrFunc? validate;
  final ValToErrFunc onSubmit;
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
