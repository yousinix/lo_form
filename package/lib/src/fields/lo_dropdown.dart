import 'package:flutter/material.dart';

import '../../core.dart';
import 'props.dart';

class LoDropdownProps = DropdownButton with Props;

class LoDropdown<TValue> extends StatelessWidget {
  final String loKey;
  final TValue? initialValue;
  final List<LoFieldBaseValidator<TValue>>? validators;
  final Duration? debounceTime;
  final List<DropdownMenuItem<TValue>> items;
  final LoDropdownProps? props;

  const LoDropdown({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    required this.items,
    this.props,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<String, TValue>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => DropdownButton<TValue?>(
        value: state.value,
        onChanged: (value) => state.onChanged(value as TValue),
        selectedItemBuilder: props?.selectedItemBuilder,
        items: items,
        key: props?.key,
        focusNode: props?.focusNode,
        style: props?.style,
        autofocus: props?.autofocus ?? false,
        onTap: props?.onTap,
        dropdownColor: props?.dropdownColor,
        disabledHint: props?.disabledHint,
        isDense: props?.isDense ?? false,
        isExpanded: props?.isExpanded ?? false,
        itemHeight: props?.itemHeight,
        focusColor: props?.focusColor,
        icon: props?.icon,
        iconDisabledColor: props?.iconDisabledColor,
        iconEnabledColor: props?.iconEnabledColor,
        iconSize: props?.iconSize ?? 24.0,
        elevation: props?.elevation ?? 8,
        menuMaxHeight: props?.menuMaxHeight,
        enableFeedback: props?.enableFeedback,
        alignment: props?.alignment ?? AlignmentDirectional.centerStart,
        borderRadius: props?.borderRadius,
        padding: props?.padding,
        underline: props?.underline ??
            Text(
              state.error ?? '',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
      ),
    );
  }
}
