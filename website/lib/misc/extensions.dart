import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
  }
}
