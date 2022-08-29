import 'package:flutter/widgets.dart';

import 'lo_field_base_validator.dart';
import 'lo_field_state.dart';
import 'lo_scope.dart';
import 'types.dart';

/// All form fields inside [LoForm] must be wrapped inside this.
class LoField<TKey, TValue> extends StatefulWidget {
  const LoField({
    Key? key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.builder,
  }) : super(key: key);

  /// {@macro LoFieldState.loKey}
  final TKey loKey;

  /// {@macro LoFieldState.initialValue}
  final TValue? initialValue;

  /// {@macro LoFieldState.validators}
  final List<LoFieldBaseValidator<TValue>>? validators;

  /// {@macro LoFieldState.debounceTime}
  final Duration? debounceTime;

  /// Builder for the field widget using [LoFieldState].
  final Widget Function(LoFieldState<TKey, TValue>) builder;

  @override
  _LoFieldState<TKey, TValue> createState() => _LoFieldState<TKey, TValue>();
}

class _LoFieldState<TKey, TValue> extends State<LoField<TKey, TValue>> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = LoScope.of<TKey>(context);
    state.registerField<TValue>(
      loKey: widget.loKey,
      initialValue: widget.initialValue,
      validators: widget.validators,
      debounceTime: widget.debounceTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = LoScope.of<TKey>(context);
    // Focus is needed to use onFocusChanged to mark fields as touched
    return Focus(
      skipTraversal:
          true, // ignore this Focus becase TextField already has one of its own
      onFocusChange: (focus) => state.onFieldFocusChanged<TValue>(
        widget.loKey,
        focus,
      ),
      debugLabel: 'LoForm:${widget.loKey.toString()}',
      child: widget.builder(
        state.fields.get<TValue>(widget.loKey),
      ),
    );
  }
}
