import 'dart:async';

class Debouncer {
  Debouncer(this.duration);

  Timer? _timer;
  final Duration duration;

  void run(void Function() action) {
    if (_timer?.isActive == true) _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() => _timer?.cancel();
}
