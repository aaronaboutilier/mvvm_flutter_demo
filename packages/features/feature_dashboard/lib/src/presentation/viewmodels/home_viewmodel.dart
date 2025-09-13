import 'package:core_analytics/core_analytics.dart';
import 'package:core_foundation/core/core.dart' as core;
import 'package:core_foundation/core/core.dart';
import 'package:feature_dashboard/src/application/usecases/clear_user.dart';
import 'package:feature_dashboard/src/application/usecases/load_user.dart';
import 'package:feature_dashboard/src/domain/entities/user.dart' as domain;
import 'package:feature_dashboard/src/presentation/viewmodels/home_view_state.dart';

/// ViewModel for the home view.
class HomeViewModel extends ChangeNotifierViewModel<HomeViewState> {
  /// Creates a [HomeViewModel] with required use cases.
  HomeViewModel({required LoadUser loadUser, required ClearUser clearUser})
    : _loadUser = loadUser,
      _clearUser = clearUser,
      super(HomeViewState.initial());

  /// The current user, if any.
  domain.User? get currentUser => state.currentUser;

  /// The number of button clicks.
  int get buttonClickCount => state.buttonClickCount;

  /// The welcome message for the user.
  String get welcomeMessage => state.currentUser != null
      ? 'Welcome back, ${state.currentUser!.name}!'
      : 'Welcome, Guest!';

  /// Whether there is a current user.
  bool get hasUser => state.hasUser;

  /// Whether the view is loading.
  bool get isLoading => state.isLoading;

  /// Error message, if any.
  String? get errorMessage => state.errorMessage;

  /// Success message, if any.
  String? get successMessage => state.successMessage;

  /// Use case for loading the user.
  final LoadUser _loadUser;

  /// Use case for clearing the user.
  final ClearUser _clearUser;

  /// Loads the user and updates the state.
  Future<void> loadUser() async {
    updateState(state.copyWith(isLoading: true).clearMessages());
    try {
      final res = await _loadUser(const core.NoParams());
      res.fold(
        failure: (f) {
          updateState(
            state.copyWith(errorMessage: f.message, currentUser: null),
          );
        },
        success: (user) {
          updateState(state.copyWith(currentUser: user).clearMessages());
        },
      );
    } catch (error) {
      updateState(
        state.copyWith(
          errorMessage: 'Failed to load user: $error',
          currentUser: null,
        ),
      );
    } finally {
      updateState(state.copyWith(isLoading: false));
    }
  }

  /// Handles button press and updates the click count.
  void onButtonPressed() {
    final action = Analytics.trackedAction(
      'dashboard_button_pressed',
      () {
        updateState(
          state.copyWith(buttonClickCount: state.buttonClickCount + 1),
        );
      },
      parameters: () => <String, Object?>{
        'count_before': state.buttonClickCount,
      },
    );
    action();
  }

  /// Clears the user and resets the state.
  Future<void> clearUser() async {
    await _clearUser(const core.NoParams());
    updateState(
      state.copyWith(currentUser: null, buttonClickCount: 0).clearMessages(),
    );
  }
}
