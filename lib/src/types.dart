import 'lo_field_state.dart';
import 'lo_form_status.dart';

typedef FieldsMap = Map<String, LoFieldState>;
typedef ValMap = Map<String, dynamic>;
typedef ErrMap = Map<String, String?>;

typedef ValidateFunc = ErrMap? Function(ValMap);
typedef FieldValidateFunc<T> = String? Function(T?);

typedef StatusCheckFunc = bool Function(LoFormStatus);
typedef SetErrFunc = void Function(ErrMap);
typedef SubmitFunc = Future<bool?>? Function(ValMap, SetErrFunc);

extension ValMapX on ValMap {
  /// Shorthand for using "as" to cast the dynamic value
  T get<T>(String key) => this[key] as T;
}

extension FieldsMapX on FieldsMap {
  /// Shorthand for using "as" to cast the dynamic value
  LoFieldState<T> get<T>(String key) {
    return this[key]! as LoFieldState<T>;
  }

  ValMap getValues() {
    return map((key, field) => MapEntry(key, field.value));
  }

  List<LoFormStatus> getStatuses() {
    return values.map((field) => field.status).toList();
  }
}