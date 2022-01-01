// ignore: avoid_classes_with_only_static_members
/// The default configuation for form'behaviour
abstract class LoConfig {
  /// The default debounce times used for each field type,
  /// when [LoField.debounceTime] is null.
  ///
  /// Example for setting debounce time for all `String` fields:
  /// ```dart
  /// LoConfig.debounceTimes[String] = const Duration(milliseconds: 300);
  /// ```
  static Map<Type, Duration> debounceTimes = {};
}
