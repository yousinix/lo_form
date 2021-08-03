import 'dart:async';
import 'dart:math';

class FakeResponse<T> {
  final bool isError;
  final String message;
  final T? data;
  final Map<String, String>? validationErrors;

  FakeResponse({
    required this.isError,
    required this.message,
    this.data,
    this.validationErrors,
  });
}

final Set<String> _usernames = {'bob', 'alice'};

class FakeApi {
  static Future<FakeResponse<String>> register({
    required String username,
    required String password,
  }) {
    // Mimic network latency
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        final random = Random();
        final isInternalError = random.nextBool();

        if (isInternalError) {
          // Mimic internal errors
          return FakeResponse(
            isError: true,
            message: 'Something wrong happened\n'
                '[💡 NOTE] This is random to mimic network failure',
          );
        }

        if (_usernames.contains(username)) {
          // Mimic validation errors
          return FakeResponse(
            isError: true,
            message: 'Invalid data',
            validationErrors: {'Username': 'Username already exists'},
          );
        } else {
          // Mimic valid response
          _usernames.add(username);
          return FakeResponse(
            isError: false,
            message: 'User registered successfully',
            data: username,
          );
        }
      },
    );
  }
}
