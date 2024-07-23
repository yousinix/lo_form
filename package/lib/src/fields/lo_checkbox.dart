import 'package:flutter/material.dart';

import '../../core.dart';
import 'props.dart';

class CheckboxProps = Checkbox with Props;

class LoCheckbox<TKey> extends StatelessWidget {
  final TKey loKey;
  final bool? initialValue;
  final List<LoFieldBaseValidator<bool>>? validators;
  final Duration? debounceTime;
  final CheckboxProps? props;
  final Widget label;
  final TextStyle? errorStyle;

  const LoCheckbox({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    this.props,
    required this.label,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<TKey, bool?>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            // [LoField] props
            onChanged: state.onChanged,
            value: state.value ?? false,

            // Other props
            key: props?.key,
            tristate: props?.tristate ?? false,
            mouseCursor: props?.mouseCursor,
            activeColor: props?.activeColor,
            fillColor: props?.fillColor,
            checkColor: props?.checkColor,
            focusColor: props?.focusColor,
            hoverColor: props?.hoverColor,
            overlayColor: props?.overlayColor,
            splashRadius: props?.splashRadius,
            materialTapTargetSize: props?.materialTapTargetSize,
            visualDensity: props?.visualDensity,
            focusNode: props?.focusNode,
            autofocus: props?.autofocus ?? false,
            shape: props?.shape,
            side: props?.side,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label,
                  if (state.error != null) ...{
                    const SizedBox(height: 2),
                    Text(
                      state.error!,
                      style: errorStyle ??
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
