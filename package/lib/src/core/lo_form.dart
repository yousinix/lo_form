import 'package:flutter/widgets.dart';

import 'lo_form_base_validator.dart';
import 'lo_form_state.dart';
import 'lo_scope.dart';
import 'types.dart';

class LoForm<TKey> extends StatefulWidget {
  const LoForm({
    Key? key,
    this.initialValues,
    this.validators,
    required this.onSubmit,
    this.onChanged,
    this.onReady,
    this.submittableWhen,
    required this.builder,
  }) : super(key: key);

  /// {@macro LoFormState.initialValues}
  final ValMap<TKey>? initialValues;

  /// {@macro LoFormState.validators}
  final List<LoFormBaseValidator<TKey>>? validators;

  /// {@macro LoFormState.onSubmit}
  final SubmitFunc<TKey> onSubmit;

  /// {@macro LoFormState.onChanged}
  final ValueChanged<LoFormState<TKey>>? onChanged;

  /// Callback function that gets executed when all fields are registered.
  final ValueChanged<LoFormState<TKey>>? onReady;

  /// {@macro LoFormState.submittableWhen}
  final StatusCheckFunc? submittableWhen;

  /// Builder function for the current [LoFormState].
  final Widget Function(LoFormState<TKey>) builder;

  @override
  _LoFormState<TKey> createState() => _LoFormState<TKey>();
}

class _LoFormState<TKey> extends State<LoForm<TKey>> {
  late final LoFormState<TKey> formState;

  @override
  void initState() {
    super.initState();

    formState = LoFormState<TKey>(
      initialValues: widget.initialValues,
      validators: widget.validators ?? [],
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
    return LoScope<TKey>(
      state: formState,
      child: Builder(
        builder: (context) {
          final state = LoScope.of<TKey>(context);
          return widget.builder(state);
        },
      ),
    );
  }
}
