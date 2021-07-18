import 'dart:async';

class FakeRepo {
  static Future<String> greet(String name) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'Hello, $name! 👋',
    );
  }
}
