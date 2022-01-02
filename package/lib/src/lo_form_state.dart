import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'lo_config.dart';
import 'lo_field_base_validator.dart';
import 'lo_field_state.dart';
import 'lo_form_base_validator.dart';
import 'lo_status.dart';
import 'types.dart';

class LoFormState extends ChangeNotifier {
  LoFormState({
    this.initialValues,
    this.validators = const [],
    this.onSubmit,
    this.onChanged,
    this.submittableWhen,
  })  : fields = {},
        status = LoStatus.pure;

  /// {@template LoFormState.initialValues}
  /// Map between [LoField.name] and their initial value.
  /// {@endtemplate}
  final ValMap? initialValues;

  /// {@template LoFormState.validators}
  /// List of the validators to run on each change.
  ///
  /// See also:
  ///
  /// - [LoFormBaseValidator], used for validation.
  /// {@endtemplate}
  final List<LoFormBaseValidator> validators;

  /// {@template LoFormState.onSubmit}
  /// Callback function that gets executed when [submit] is called with
  /// fields' values as first parameter and setError function as second one
  /// which is used to set external API errors.
  ///
  /// Should return:
  ///  - true if the submission has succeeded.
  ///  - false if the submission has failed.
  ///  - null if the submission has API errors (use setError to set them).
  /// {@endtemplate}
  final SubmitFunc? onSubmit;

  /// {@template LoFormState.onChanged}
  /// Callback function that gets executed when any field or status are changed.
  /// {@endtemplate}
  final ValueChanged<LoFormState>? onChanged;

  /// {@template LoFormState.submittableWhen}
  /// Predicate that defines when the form can be submitted.
  /// {@endtemplate}
  final StatusCheckFunc? submittableWhen;

  /// Map between [LoField.name] and their [LoFieldState].
  final FieldsMap fields;

  /// Current form status, [LoStatusX.and] method is used to evaluate this.
  LoStatus status;

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
    required List<LoFieldBaseValidator<T>>? validators,
    Duration? debounceTime,
  }) {
    if (fields.containsKey(name)) return; // Prevent re-registration

    fields[name] = LoFieldState<T>(
      name: name,
      onChanged: (v) => onFieldValueChanged(name, v),
      validators: validators ?? [],
      initialValue: initialValue ?? initialValues?[name] as T?,
      debounceTime: debounceTime ?? LoConfig.debounceTimes[T],
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

    final fieldError = LoFieldBaseValidator.run(field.validators, value);
    final formErrors = LoFormBaseValidator.run(validators, fields.getValues());
    final formError = formErrors.remove(name);
    final errors = {
      ...formErrors,
      name: fieldError ?? formError,
    };

    setErrors(errors);
    notifyListeners();
  }

  /// Submits form using the current values and calls [onSubmit],
  /// modifies status based on the result.
  Future<void> handleSubmit() async {
    status = LoStatus.loading;
    notifyListeners();

    final result = await onSubmit?.call(fields.getValues(), setErrors);

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

  @override
  void dispose() {
    super.dispose();
    fields.forEach((_, field) => field.dispose());
  }
}
