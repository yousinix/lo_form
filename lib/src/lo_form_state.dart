import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'lo_field_state.dart';
import 'lo_status.dart';
import 'types.dart';

class LoFormState extends ChangeNotifier {
  final FieldsMap fields;
  final ValMap? initialValues;
  final ValidateFunc? validate;
  final SubmitFunc onSubmit;
  final ValueChanged<LoFormState>? onChanged;
  final StatusCheckFunc? submittableWhen;

  LoStatus status;

  LoFormState({
    this.initialValues,
    this.validate,
    required this.onSubmit,
    this.onChanged,
    this.submittableWhen,
  })  : fields = {},
        status = LoStatus.pure;

  /// Returns the [handleSubmit] method if [submittableWhen]
  /// is null or true, otherwise returns null.
  Future<void> Function()? get submit {
    final canSubmit = submittableWhen?.call(status) ?? true;
    return canSubmit ? handleSubmit : null;
  }

  @internal
  @override
  void notifyListeners() {
    onChanged?.call(this);
    super.notifyListeners();
  }

  T? valueOf<T>(String key) => fields[key]!.value as T?;

  @internal
  void registerField<T>({
    required String name,
    T? initialValue,
    required FieldValidateFunc<T>? validate,
  }) {
    if (fields.containsKey(name)) return; // Prevent re-registration

    fields[name] = LoFieldState<T>(
      name: name,
      onChanged: (v) => onFieldValueChanged(name, v),
      validate: validate,
      initialValue: initialValue ?? initialValues?[name] as T?,
    );
  }

  @internal
  void onFieldFocusChanged<T>(String name, bool isFocused) {
    final field = fields.get<T>(name);

    if (isFocused) {
      field.touched = true;
      notifyListeners();
    } else if (field.status.isPure) {
      // Validate pure fields when unfocused
      final value = valueOf<T>(name);
      onFieldValueChanged<T>(name, value);
    }
  }

  @internal
  void onFieldValueChanged<T>(String name, T? value) {
    final field = fields.get<T>(name);

    field.value = value;
    field.touched = true;

    final fieldError = field.validate?.call(value);
    final formErrors = validate?.call(fields.getValues()) ?? {};
    final formError = formErrors.remove(name);
    final errors = {
      ...formErrors,
      name: fieldError ?? formError,
    };

    setErrors(errors);
    notifyListeners();
  }

  Future<void> handleSubmit() async {
    status = LoStatus.loading;
    notifyListeners();

    final result = await onSubmit(fields.getValues(), setErrors);

    // When no result is returned, means the form became invalid
    if (result != null) {
      status = result ? LoStatus.success : LoStatus.failure;
    }

    notifyListeners();
  }

  @internal
  void setErrors(ErrMap? map) {
    if (map == null) return;

    fields.forEach((name, field) {
      // Field must be touched to assign errors to it
      if (field.touched && map.containsKey(name)) {
        // When the map has the key but with a null value,
        // this means to clear the field's error
        field.error = map[name];
      }
    });

    status = fields.getStatuses().reduce((res, x) => res.and(x));
  }
}
