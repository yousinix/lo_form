import 'package:flutter/widgets.dart';

import 'lo_field_base_validator.dart';
import 'lo_field_state.dart';
import 'lo_scope.dart';
import 'types.dart';

/// All form fields inside [LoForm] must be wrapped inside this.
class LoField<TKey, TValue> extends StatefulWidget {
  const LoField({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.builder,
  });

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
  // ignore: library_private_types_in_public_api
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
      // Ignore this Focus because LoFields already have their own
      skipTraversal: true,
      onFocusChange: (focus) => state.onFieldFocusChanged<TValue>(
        widget.loKey,
        focus,
      ),
      child: widget.builder(
        state.fields.get<TValue>(widget.loKey),
      ),
    );
  }
}
