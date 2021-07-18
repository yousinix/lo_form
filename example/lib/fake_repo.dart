import 'dart:async';

class FakeRepo {
  static Future<String> greet(String name) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'Hello, $name! 👋',
    );
  }

  static Future<bool> isUnique(String name) {
    final usedNames = {'bob', 'alice'};

    return Future.delayed(
      const Duration(seconds: 2),
      () => !usedNames.contains(name),
    );
  }
}
