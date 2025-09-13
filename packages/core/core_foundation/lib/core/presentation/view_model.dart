/// Base interface for a ViewModel with state and stream.
abstract class ViewModel<T> {
  /// Gets the current state.
  T get state;

  /// Gets the stream of state updates.
  Stream<T> get stateStream;

  /// Disposes the ViewModel.
  void dispose();
}

/// Interface for managing state with update and stream capabilities.
abstract class StateManager<T> {
  /// Gets the current state.
  T get state;

  /// Gets the stream of state updates.
  Stream<T> get stateStream;

  /// Updates the state.
  void updateState(T newState);

  /// Disposes the state manager.
  void dispose();
}
