import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_form_state.dart';

class LoForm extends StatefulWidget {
  final ValMap? initialValues;
  final ValidateFunc? validate;
  final SubmitFunc onSubmit;
  final ValueChanged<LoFormState>? onChanged;
  final ValueChanged<LoFormState>? onReady;
  final StatusCheckFunc? submittableWhen;
  final Widget Function(LoFormState) builder;

  const LoForm({
    Key? key,
    this.initialValues,
    this.validate,
    required this.onSubmit,
    this.onChanged,
    this.onReady,
    this.submittableWhen,
    required this.builder,
  }) : super(key: key);

  @override
  _LoFormState createState() => _LoFormState();
}

class _LoFormState extends State<LoForm> {
  late final LoFormState formState;

  @override
  void initState() {
    super.initState();

    formState = LoFormState(
      initialValues: widget.initialValues,
      validate: widget.validate,
      onSubmit: widget.onSubmit,
      onChanged: widget.onChanged,
      submittableWhen: widget.submittableWhen,
    );

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => widget.onReady?.call(formState),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => formState,
      child: Consumer<LoFormState>(
        builder: (_, state, __) => widget.builder(state),
      ),
    );
  }
}
