import 'package:flutter/foundation.dart';

import 'lo_field_state.dart';
import 'lo_form_status.dart';
import 'types.dart';

class LoFormState extends ChangeNotifier {
  final FieldsMap fields;
  final ValMap? initialValues;
  final ValidateFunc? validate;
  final SubmitFunc onSubmit;
  final ValueChanged<LoFormState>? onChanged;
  final StatusCheckFunc? submittableWhen;

  LoFormStatus status;

  LoFormState({
    this.initialValues,
    this.validate,
    required this.onSubmit,
    this.onChanged,
    this.submittableWhen,
  })  : fields = {},
        status = LoFormStatus.pure;

  /// Returns the [handleSubmit] method if [submittableWhen]
  /// is null or true, otherwise returns null.
  Future<void> Function()? get submit {
    final canSubmit = submittableWhen?.call(status) ?? true;
    return canSubmit ? handleSubmit : null;
  }

  void _notifyChanged() {
    onChanged?.call(this);
    notifyListeners();
  }

  /// Gets field value
  T? get<T>(String key) => fields[key]!.value as T?;

  void registerField<T>({
    required String name,
    T? initialValue,
    required FieldValidateFunc<T>? validate,
  }) {
    if (fields.containsKey(name)) return; // Prevent re-registration

    fields[name] = LoFieldState<T>(
      initialValue: initialValue ?? initialValues?[name] as T?,
      name: name,
      status: LoFormStatus.pure,
      touched: false,
      onChanged: (v) => onFieldValueChanged(name, v),
      validate: validate,
    );
  }

  void onFieldFocusChanged<T>(String name, bool isFocused) {
    final field = fields.get<T>(name);

    if (isFocused) {
      field.touched = true;
      _notifyChanged();
    } else if (field.status.isPure) {
      // Validate pure fields when unfocused
      final value = get<T>(name);
      onFieldValueChanged<T>(name, value);
    }
  }

  void onFieldValueChanged<T>(String name, T? value) {
    final field = fields.get<T>(name);

    field.value = value;
    field.touched = true;

    // Always remove errors related to this field from the form-level errors,
    // because they will be handled by this method.
    final formLevelErrors = validate?.call(fields.getValues());
    final formFieldError = formLevelErrors?.remove(name);
    final fieldLevelError = field.validate?.call(value);
    field.error = fieldLevelError ?? formFieldError;

    setErrors(formLevelErrors);
    _updateFieldStatus<T>(name);
    _notifyChanged();
  }

  void _updateFieldStatus<T>(String name) {
    final field = fields.get<T>(name);

    if (field.error != null) {
      field.status = LoFormStatus.invalid;
    } else if (field.value == field.initialValue) {
      field.status = LoFormStatus.pure;
    } else {
      field.status = LoFormStatus.valid;
    }

    status = fields.getStatuses().reduce((res, x) => res.and(x));
  }

  Future<void> handleSubmit() async {
    status = LoFormStatus.loading;
    _notifyChanged();

    final result = await onSubmit(fields.getValues(), setErrors);

    // When no result is returned, means the form became invalid
    if (result != null) {
      status = result ? LoFormStatus.success : LoFormStatus.failure;
    }

    _notifyChanged();
  }

  void setErrors(ErrMap? map) {
    if (map == null) return;
    status = LoFormStatus.invalid;

    fields.forEach((name, field) {
      // Field must be touched to assign errors to it
      if (field.touched && map.containsKey(name)) {
        // When the map has the key but with a null value,
        // this means to clear the field's error
        final clearError = map[name] == null;
        field.status = clearError ? LoFormStatus.valid : LoFormStatus.invalid;
        field.error = map[name];
      }
    });
  }
}
