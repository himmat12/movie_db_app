import 'dart:async';

enum EventAction { increment, decrement, reset }

class TestBloc {
  late int count;
  final _testBlocStateController = StreamController<int>();
  Stream<int> get testStateStream =>
      _testBlocStateController.stream.asBroadcastStream();

  final _testBlocEventController = StreamController<EventAction>();
  StreamSink<EventAction> get testBlocEventSink =>
      _testBlocEventController.sink;

  TestBloc() {
    count = 0;

    Future.delayed(const Duration(seconds: 3));

    _testBlocEventController.stream.listen((event) {
      if (event == EventAction.increment) {
        count++;
      } else if (event == EventAction.decrement) {
        count--;
      } else if (event == EventAction.reset) {
        count = 0;
      }

      _testBlocStateController.sink.add(count);
    });
  }
}
