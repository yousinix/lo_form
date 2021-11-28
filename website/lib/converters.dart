import 'dart:convert';

import 'package:lo_form/lo_form.dart';

String formStateToJson(LoFormState state) {
  final map = formStateToMap(state);
  final encoder = JsonEncoder();
  return encoder.convert(map);
}

String statusToString(LoStatus status) {
  return status.toString().split('.')[1];
}

Map<String, dynamic> formStateToMap(LoFormState state) {
  return {
    "status": statusToString(state.status),
    "fields": state.fields.values.map(fieldStateToMap).toList(),
  };
}

Map<String, dynamic> fieldStateToMap(LoFieldState state) {
  return {
    "name": state.name,
    "status": statusToString(state.status),
    "touched": state.touched,
    "initialValue": state.initialValue,
    "value": state.value,
    "error": state.error,
  };
}
