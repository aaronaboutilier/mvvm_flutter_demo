abstract class ViewModel<T> {
  T get state;
  Stream<T> get stateStream;
  void dispose();
}

abstract class StateManager<T> {
  T get state;
  Stream<T> get stateStream;
  void updateState(T newState);
  void dispose();
}
