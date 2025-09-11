// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../core/core.dart' as core;
import '../features/home/application/usecases/clear_user.dart';
import '../features/home/application/usecases/load_user.dart';
import '../features/home/domain/entities/user.dart' as domain;
import '../features/home/infrastructure/repositories/in_memory_user_repository.dart';

/// HomeViewModel manages the state and business logic for the home screen
/// This is the ViewModel part of MVVM - it sits between the View and Model
/// 
/// ChangeNotifier allows this class to notify listeners when data changes
/// This is crucial for reactive UI updates in MVVM
class HomeViewModel extends ChangeNotifier {
  // Private fields to store state
  domain.User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  int _buttonClickCount = 0;

  // Public getters to expose state to the View
  // The View should never directly modify private fields
  domain.User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get buttonClickCount => _buttonClickCount;

  // Computed properties that derive from state
  String get welcomeMessage => _currentUser != null 
      ? 'Welcome back, ${_currentUser!.name}!' 
      : 'Welcome, Guest!';
  
  bool get hasUser => _currentUser != null;

  /// Simulates loading a user (like from an API or database)
  /// This demonstrates how ViewModels handle asynchronous operations
  final LoadUser _loadUser;
  final ClearUser _clearUser;

  HomeViewModel()
      : this.withRepository(InMemoryUserRepository());

  HomeViewModel.withRepository(InMemoryUserRepository repo)
      : _loadUser = LoadUser(repo),
        _clearUser = ClearUser(repo);

  Future<void> loadUser() async {
    // Set loading state and notify listeners
    _setLoading(true);
    _clearError();

    try {
      final res = await _loadUser(const core.NoParams());
      res.fold(
        failure: (f) {
          _errorMessage = f.message;
          _currentUser = null;
        },
        success: (user) {
          _currentUser = user;
          _errorMessage = null;
        },
      );

      // Success - clear any previous errors
    } catch (error) {
      // Handle errors gracefully
      _errorMessage = 'Failed to load user: $error';
      _currentUser = null;
    } finally {
      // Always clear loading state
      _setLoading(false);
    }
  }

  /// Handles button click events
  /// This shows how ViewModels process user interactions
  void onButtonPressed() {
    _buttonClickCount++;
    // Notify all listeners that the state has changed
    // This will trigger UI rebuilds in any listening widgets
    notifyListeners();
    
    // You could add more business logic here, like:
    // - Logging analytics events
    // - Triggering other side effects
    // - Validating conditions before proceeding
  }

  /// Resets the user state (like logging out)
  Future<void> clearUser() async {
    await _clearUser(const core.NoParams());
    _currentUser = null;
    _buttonClickCount = 0;
    _clearError();
    notifyListeners();
  }

  // Private helper methods to manage state changes
  // These ensure consistent state management and notification patterns

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    // Note: We don't always need to call notifyListeners() here
    // since this is usually called before other state changes
  }

  /// Clean up resources when the ViewModel is disposed
  /// This is important for preventing memory leaks
  @override
  void dispose() {
    // Cancel any ongoing operations, close streams, etc.
    super.dispose();
  }
}