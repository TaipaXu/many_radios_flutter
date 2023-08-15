import 'dart:async';

class GenericEvent<T> {
  final String eventName;
  final T? eventData;

  GenericEvent(this.eventName, this.eventData);
}

class EventBus<T> {
  final StreamController<GenericEvent<T>> _eventController =
      StreamController<GenericEvent<T>>.broadcast();

  Stream<GenericEvent<T>> get eventStream => _eventController.stream;

  void fireEvent(String eventName, [T? eventData]) {
    _eventController.add(GenericEvent(eventName, eventData));
  }

  StreamSubscription<GenericEvent<T>> addEventListener(
      void Function(GenericEvent<T>) listener) {
    return eventStream.listen(listener);
  }

  void dispose() {
    _eventController.close();
  }
}
