import 'dart:async';

import 'lo_field_state.dart';
import 'lo_status.dart';

typedef FieldsMap<TKey> = Map<TKey, LoFieldState<TKey, dynamic>>;
typedef ValMap<TKey> = Map<TKey, dynamic>;
typedef ErrMap<TKey> = Map<TKey, String?>;

typedef StatusCheckFunc = bool Function(LoStatus);
typedef SetErrFunc<TKey> = void Function(ErrMap<TKey>);
typedef SubmitFunc<TKey> = FutureOr<bool?>? Function(
  ValMap<TKey>,
  SetErrFunc<TKey>,
);

extension ValMapX<TKey> on ValMap<TKey> {
  /// Shorthand for using "as" to cast the dynamic value
  T get<T>(TKey key) => this[key] as T;
}

extension FieldsMapX<TKey> on FieldsMap<TKey> {
  /// Shorthand for using "as" to cast the dynamic value
  LoFieldState<TKey, TValue> get<TValue>(TKey key) {
    return this[key]! as LoFieldState<TKey, TValue>;
  }

  ValMap<TKey> getValues() {
    return map((key, field) => MapEntry(key, field.value));
  }

  List<LoStatus> getStatuses() {
    return values.map((field) => field.status).toList();
  }
}
