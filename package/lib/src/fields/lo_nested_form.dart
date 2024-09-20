import 'package:flutter/widgets.dart';
import '../../core.dart';

class LoNestedForm<TParentKey, TChildKey> extends StatelessWidget {
  final TParentKey loKey;
  final List<LoFieldBaseValidator<ValMap<TChildKey>>>? validators;
  final Duration? debounceTime;
  final Widget Function(LoFormState<TChildKey>) childFormBuilder;
  final SubmitFunc<TChildKey>? onSubmit;

  const LoNestedForm({
    super.key,
    required this.loKey,
    this.validators,
    this.debounceTime,
    required this.childFormBuilder,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return LoField<TParentKey, ValMap<TChildKey>>(
      loKey: loKey,
      validators: validators,
      debounceTime: debounceTime,
      builder: (state) {
        return LoForm<TChildKey>(
          initialValues: state.value,
          onChanged: (childForm) {
            state.onChanged(childForm.fields.getValues());
          },
          onSubmit: (values, setErrors) async {
            if (onSubmit != null) {
              final result = await onSubmit!(values, setErrors);
              if (result != null) {
                return result;
              }
            }

            if (context.mounted) {
              final parentForm = LoScope.of<TParentKey>(context);
              await parentForm.submit?.call();
              return true;
            } else {
              return false;
            }
          },
          builder: childFormBuilder,
        );
      },
    );
  }
}
