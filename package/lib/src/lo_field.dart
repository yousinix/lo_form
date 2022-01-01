import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'lo_field_state.dart';
import 'lo_form_state.dart';
import 'types.dart';

/// All form fields inside [LoForm] must be wrapped inside this.
class LoField<T> extends StatefulWidget {
  const LoField({
    Key? key,
    required this.name,
    this.initialValue,
    this.validate,
    this.debounceTime,
    required this.builder,
  }) : super(key: key);

  /// {@macro LoFieldState.name}
  final String name;

  /// {@macro LoFieldState.initialValue}
  final T? initialValue;

  /// {@macro LoFieldState.validate}
  final FieldValidateFunc<T>? validate;

  /// The [Duration] use to debounce changes of [LoFieldState.onChange]
  final Duration? debounceTime;

  /// Builder for the field widget using [LoFieldState].
  final Widget Function(LoFieldState<T>) builder;

  @override
  _LoFieldState<T> createState() => _LoFieldState<T>();
}

class _LoFieldState<T> extends State<LoField<T>> {
  @override
  void initState() {
    super.initState();
    context.read<LoFormState>().registerField(
          name: widget.name,
          initialValue: widget.initialValue,
          validate: widget.validate,
          debounceTime: widget.debounceTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoFormState>(
      builder: (_, form, __) {
        return FocusScope(
          child: Focus(
            onFocusChange: (focus) => form.onFieldFocusChanged<T>(
              widget.name,
              focus,
            ),
            child: widget.builder(
              form.fields.get<T>(widget.name),
            ),
          ),
        );
      },
    );
  }
}
