class Monitor {
  var _signal = false;
  final Duration waitTime;
  final int tries;

  Monitor({
    this.waitTime = const Duration(),
    this.tries = 100,
  });

  void signal() {
    _signal = true;
  }

  Future wait() {
    var tries = this.tries;
    return Future.doWhile(() async {
      await Future.delayed(waitTime);
      return !_signal && tries-- > 0;
    });
  }
}
