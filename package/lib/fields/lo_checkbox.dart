import 'package:flutter/material.dart';

import '../lo_form.dart';
import 'props.dart';

class CheckboxProps = Checkbox with Props;

class LoCheckbox extends StatelessWidget {
  final String name;
  final bool? initialValue;
  final FieldValidateFunc<bool>? validate;
  final Duration? debounceTime;
  final CheckboxProps? props;
  final Widget label;
  final TextStyle? errorStyle;

  const LoCheckbox({
    Key? key,
    required this.name,
    this.initialValue,
    this.validate,
    this.debounceTime,
    this.props,
    required this.label,
    this.errorStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoField<bool?>(
      name: name,
      initialValue: initialValue,
      validate: validate,
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
                          Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).errorColor,
                              ),
                    ),
                  }
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
