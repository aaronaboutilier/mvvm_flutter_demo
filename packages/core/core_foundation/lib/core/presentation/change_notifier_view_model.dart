import 'dart:async';
import 'package:flutter/foundation.dart';

import 'view_model.dart';

class ChangeNotifierViewModel<T> implements ViewModel<T> {
  final StateManager<T> _stateManager;

  ChangeNotifierViewModel(T initialState)
      : _stateManager = ChangeNotifierStateManager<T>(initialState);

  @override
  T get state => _stateManager.state;

  @override
  Stream<T> get stateStream => _stateManager.stateStream;

  void updateState(T newState) => _stateManager.updateState(newState);

  @override
  void dispose() => _stateManager.dispose();
}

class ChangeNotifierStateManager<T> extends ChangeNotifier implements StateManager<T> {
  final StreamController<T> _stateController = StreamController<T>.broadcast();

  late T _state;

  ChangeNotifierStateManager(this._state);

  @override
  T get state => _state;

  @override
  Stream<T> get stateStream => _stateController.stream;

  @override
  void updateState(T newState) {
    _state = newState;
    _stateController.add(_state);
    notifyListeners();
  }

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}
