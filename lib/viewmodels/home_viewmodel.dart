// lib/viewmodels/home_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../models/user.dart';

/// HomeViewModel manages the state and business logic for the home screen
/// This is the ViewModel part of MVVM - it sits between the View and Model
/// 
/// ChangeNotifier allows this class to notify listeners when data changes
/// This is crucial for reactive UI updates in MVVM
class HomeViewModel extends ChangeNotifier {
  // Private fields to store state
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  int _buttonClickCount = 0;

  // Public getters to expose state to the View
  // The View should never directly modify private fields
  User? get currentUser => _currentUser;
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
  Future<void> loadUser() async {
    // Set loading state and notify listeners
    _setLoading(true);
    _clearError();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate loading user data
      _currentUser = const User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
      );

      // Success - clear any previous errors
      _errorMessage = null;
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
  void clearUser() {
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