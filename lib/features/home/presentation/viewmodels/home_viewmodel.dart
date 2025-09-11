import '../../../../core/core.dart';
import '../../../../core/core.dart' as core;
import '../../../home/application/usecases/clear_user.dart';
import '../../../home/application/usecases/load_user.dart';
import '../../../home/domain/entities/user.dart' as domain;

class HomeViewModel extends BaseViewModel {
  domain.User? _currentUser;
  int _buttonClickCount = 0;

  domain.User? get currentUser => _currentUser;
  int get buttonClickCount => _buttonClickCount;
  String get welcomeMessage => _currentUser != null
      ? 'Welcome back, ${_currentUser!.name}!'
      : 'Welcome, Guest!';
  bool get hasUser => _currentUser != null;

  final LoadUser _loadUser;
  final ClearUser _clearUser;

  HomeViewModel({required LoadUser loadUser, required ClearUser clearUser})
      : _loadUser = loadUser,
        _clearUser = clearUser;

  Future<void> loadUser() async {
    setLoading(true);
    clearMessages();
    try {
      final res = await _loadUser(const core.NoParams());
      res.fold(
        failure: (f) {
          setError(f.message);
          _currentUser = null;
        },
        success: (user) {
          _currentUser = user;
          clearMessages();
        },
      );
    } catch (error) {
      setError('Failed to load user: $error');
      _currentUser = null;
    } finally {
      setLoading(false);
    }
  }

  void onButtonPressed() {
    _buttonClickCount++;
    notifyListeners();
  }

  Future<void> clearUser() async {
    await _clearUser(const core.NoParams());
    _currentUser = null;
    _buttonClickCount = 0;
    clearMessages();
    notifyListeners();
  }
}
