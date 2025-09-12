import 'package:core_foundation/core/core.dart';
import 'package:core_foundation/core/core.dart' as core;
import '../../application/usecases/clear_user.dart';
import '../../application/usecases/load_user.dart';
import '../../domain/entities/user.dart' as domain;
import 'home_view_state.dart';

class HomeViewModel extends ChangeNotifierViewModel<HomeViewState> {
  domain.User? get currentUser => state.currentUser;
  int get buttonClickCount => state.buttonClickCount;
  String get welcomeMessage => state.currentUser != null
      ? 'Welcome back, ${state.currentUser!.name}!'
      : 'Welcome, Guest!';
  bool get hasUser => state.hasUser;
  bool get isLoading => state.isLoading;
  String? get errorMessage => state.errorMessage;
  String? get successMessage => state.successMessage;

  final LoadUser _loadUser;
  final ClearUser _clearUser;

  HomeViewModel({required LoadUser loadUser, required ClearUser clearUser})
      : _loadUser = loadUser,
        _clearUser = clearUser,
        super(HomeViewState.initial());

  Future<void> loadUser() async {
    updateState(state.copyWith(isLoading: true).clearMessages());
    try {
      final res = await _loadUser(const core.NoParams());
      res.fold(
        failure: (f) {
          updateState(state.copyWith(errorMessage: f.message, currentUser: null));
        },
        success: (user) {
          updateState(state.copyWith(currentUser: user).clearMessages());
        },
      );
    } catch (error) {
      updateState(state.copyWith(errorMessage: 'Failed to load user: $error', currentUser: null));
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  void onButtonPressed() {
    updateState(state.copyWith(buttonClickCount: state.buttonClickCount + 1));
  }

  Future<void> clearUser() async {
    await _clearUser(const core.NoParams());
    updateState(state.copyWith(currentUser: null, buttonClickCount: 0).clearMessages());
  }
}
