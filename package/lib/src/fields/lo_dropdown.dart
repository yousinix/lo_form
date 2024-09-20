import 'package:flutter/material.dart';

import '../../core.dart';

class DropdownProps {
  final Key? key;
  final FocusNode? focusNode;
  final TextStyle? style;
  final bool autofocus;
  final VoidCallback? onTap;
  final Color? dropdownColor;
  final Widget? disabledHint;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final int elevation;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final InputDecoration? decoration;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const DropdownProps({
    this.key,
    this.focusNode,
    this.style,
    this.autofocus = false,
    this.onTap,
    this.dropdownColor,
    this.disabledHint,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.focusColor,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.elevation = 8,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.padding,
    this.decoration,
    this.selectedItemBuilder,
  });
}

class LoDropdown<TValue> extends StatelessWidget {
  final String loKey;
  final TValue? initialValue;
  final List<LoFieldBaseValidator<TValue>>? validators;
  final Duration? debounceTime;
  final List<DropdownMenuItem<TValue>> items;
  final DropdownProps? props;

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
      builder: (state) => DropdownButtonFormField<TValue?>(
        value: state.value,
        onChanged: (value) => state.onChanged(value as TValue),
        items: items,
        // Apply all properties from DropdownProps
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
        selectedItemBuilder: props?.selectedItemBuilder,
        decoration: (props?.decoration ??
                InputDecoration(
                  errorText: state.error,
                ))
            .applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }
}
