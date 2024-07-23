import 'package:flutter/widgets.dart';

import 'lo_form_base_validator.dart';
import 'lo_form_state.dart';
import 'lo_scope.dart';
import 'types.dart';

class LoForm<TKey> extends StatefulWidget {
  const LoForm({
    super.key,
    this.initialValues,
    this.validators,
    required this.onSubmit,
    this.onChanged,
    this.onReady,
    this.submittableWhen,
    required this.builder,
  });

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
  // ignore: library_private_types_in_public_api
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

    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback(
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

/// This allows a value of type T or T?
/// to be treated as a value of type T?.
///
/// We use this so that APIs that have become
/// non-nullable can still be used with `!` and `?`
/// to support older versions of the API as well.
///
/// For more info:
/// https://docs.flutter.dev/development/tools/sdk/release-notes/release-notes-3.0.0
T? _ambiguate<T>(T? value) => value;
