import 'package:flutter/material.dart';

import '../../core.dart';
import 'props.dart';

class TextFieldProps = TextField with Props;

class LoTextField<TKey> extends StatelessWidget {
  final TKey loKey;
  final String? initialValue;
  final List<LoFieldBaseValidator<String>>? validators;
  final Duration? debounceTime;
  final TextFieldProps? props;

  const LoTextField({
    super.key,
    required this.loKey,
    this.initialValue,
    this.validators,
    this.debounceTime,
    this.props,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<TKey, String>(
      loKey: loKey,
      initialValue: initialValue,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) => TextFormField(
        // [LoField] props
        initialValue: state.initialValue,
        decoration: _mergeDecoration(props?.decoration, state),
        onChanged: (v) {
          state.onChanged(v);
          props?.onChanged?.call(v);
        },

        // Other props
        key: props?.key,
        controller: props?.controller,
        focusNode: props?.focusNode,
        keyboardType: props?.keyboardType,
        textInputAction: props?.textInputAction,
        textCapitalization:
            props?.textCapitalization ?? TextCapitalization.none,
        style: props?.style,
        strutStyle: props?.strutStyle,
        textAlign: props?.textAlign ?? TextAlign.start,
        textAlignVertical: props?.textAlignVertical,
        textDirection: props?.textDirection,
        readOnly: props?.readOnly ?? false,
        contextMenuBuilder: props?.contextMenuBuilder,
        showCursor: props?.showCursor,
        autofocus: props?.autofocus ?? false,
        obscuringCharacter: props?.obscuringCharacter ?? '•',
        obscureText: props?.obscureText ?? false,
        autocorrect: props?.autocorrect ?? true,
        smartDashesType: props?.smartDashesType,
        smartQuotesType: props?.smartQuotesType,
        enableSuggestions: props?.enableSuggestions ?? true,
        maxLines: props?.maxLines ?? 1,
        minLines: props?.minLines,
        expands: props?.expands ?? false,
        maxLength: props?.maxLength,
        maxLengthEnforcement: props?.maxLengthEnforcement,
        onEditingComplete: props?.onEditingComplete,
        // onSubmitted: props?.onSubmitted,
        // onAppPrivateCommand: props?.onAppPrivateCommand,
        inputFormatters: props?.inputFormatters,
        enabled: props?.enabled,
        cursorWidth: props?.cursorWidth ?? 2.0,
        cursorHeight: props?.cursorHeight,
        cursorRadius: props?.cursorRadius,
        cursorColor: props?.cursorColor,
        // selectionHeightStyle: props?.selectionHeightStyle ?? BoxHeightStyle.tight,
        // selectionWidthStyle: props?.selectionWidthStyle ?? BoxWidthStyle.tight,
        keyboardAppearance: props?.keyboardAppearance,
        scrollPadding: props?.scrollPadding ?? const EdgeInsets.all(20.0),
        // dragStartBehavior: props?.dragStartBehavior ?? DragStartBehavior.start,
        enableInteractiveSelection: props?.enableInteractiveSelection ?? true,
        selectionControls: props?.selectionControls,
        onTap: props?.onTap,
        // mouseCursor: props?.mouseCursor,
        buildCounter: props?.buildCounter,
        scrollController: props?.scrollController,
        scrollPhysics: props?.scrollPhysics,
        autofillHints: props?.autofillHints,
        // restorationId: props?.restorationId,
      ),
    );
  }

  InputDecoration _mergeDecoration(
    InputDecoration? other,
    LoFieldState<TKey, String> state,
  ) {
    return other == null
        ? InputDecoration(
            errorText: state.error,
            hintText: '${state.loKey}',
          )
        : other.copyWith(
            errorText: state.error,
            hintText: other.hintText ?? '${state.loKey}',
          );
  }
}
