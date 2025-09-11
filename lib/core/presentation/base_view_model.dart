import 'package:flutter/foundation.dart';

/// BaseViewModel provides common state and helpers for MVVM ViewModels.
/// Centralizes loading and message handling to keep feature VMs lean.
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Run an async operation with standardized loading and error handling.
  @protected
  Future<void> performOperation(
    String operation,
    Future<void> Function() body,
  ) async {
    setLoading(true);
    clearMessages();
    try {
      debugPrint('Starting: $operation');
      await body();
      debugPrint('Completed: $operation');
    } catch (e) {
      debugPrint('Error during $operation: $e');
      setError('Failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  @protected
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @protected
  void setError(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  @protected
  void setSuccess(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  @protected
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
