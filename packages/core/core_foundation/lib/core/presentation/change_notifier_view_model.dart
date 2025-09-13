import 'dart:async';

import 'package:core_foundation/core/presentation/view_model.dart';
import 'package:flutter/foundation.dart';

/// A [ViewModel] implementation using [ChangeNotifier] for state management.
class ChangeNotifierViewModel<T> implements ViewModel<T> {
  /// Creates a [ChangeNotifierViewModel] with the given initial state.
  ChangeNotifierViewModel(T initialState)
    : _stateManager = ChangeNotifierStateManager<T>(initialState);

  /// Internal state manager.
  final StateManager<T> _stateManager;

  /// Gets the current state.
  @override
  T get state => _stateManager.state;

  /// Gets the stream of state updates.
  @override
  Stream<T> get stateStream => _stateManager.stateStream;

  /// Updates the state.
  void updateState(T newState) => _stateManager.updateState(newState);

  /// Disposes the state manager.
  @override
  void dispose() => _stateManager.dispose();
}

/// State manager using [ChangeNotifier] and a broadcast stream.
class ChangeNotifierStateManager<T> extends ChangeNotifier
    implements StateManager<T> {
  /// Creates a [ChangeNotifierStateManager] with the given initial state.
  ChangeNotifierStateManager(this._state);

  /// Broadcast stream controller for state updates.
  final StreamController<T> _stateController = StreamController<T>.broadcast();

  /// Internal state.
  late T _state;

  /// Gets the current state.
  @override
  T get state => _state;

  /// Gets the stream of state updates.
  @override
  Stream<T> get stateStream => _stateController.stream;

  /// Updates the state and notifies listeners.
  @override
  void updateState(T newState) {
    _state = newState;
    _stateController.add(_state);
    notifyListeners();
  }

  /// Disposes the stream controller and notifies listeners.
  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}
