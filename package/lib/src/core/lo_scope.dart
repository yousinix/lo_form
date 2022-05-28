import 'package:flutter/widgets.dart';

import '../../core.dart';

class LoScope<TKey> extends InheritedNotifier<LoFormState<TKey>> {
  const LoScope({
    Key? key,
    required LoFormState<TKey> state,
    required Widget child,
  }) : super(
          key: key,
          notifier: state,
          child: child,
        );

  static LoFormState<TKey> of<TKey>(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LoScope<TKey>>();
    assert(result != null, 'No $LoScope<$TKey> found in context');
    return result!.notifier!;
  }
}
