import 'dart:async';

final Set<String> _usernames = {'bob', 'alice'};

class FakeApi {
  static Future<String> register({
    required String username,
    required String password,
  }) {
    // Delayed future to simulate network call
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        if (_usernames.contains(username)) {
          return Future.error('Username already exists');
        } else {
          _usernames.add(username);
          return Future.value('Registered Successfully');
        }
      },
    );
  }
}
