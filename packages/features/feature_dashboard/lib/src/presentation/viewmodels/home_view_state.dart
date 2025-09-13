import 'package:feature_dashboard/src/domain/entities/user.dart' as domain;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_state.freezed.dart';

/// State for the home view.
@freezed
class HomeViewState with _$HomeViewState {
  /// Creates a [HomeViewState].
  const factory HomeViewState({
    /// The current user, if any.
    domain.User? currentUser,

    /// The number of button clicks.
    @Default(0) int buttonClickCount,

    /// Whether the view is loading.
    @Default(false) bool isLoading,

    /// Error message, if any.
    String? errorMessage,

    /// Success message, if any.
    String? successMessage,
  }) = _HomeViewState;

  /// Private constructor for [HomeViewState].
  const HomeViewState._();

  /// Returns the initial [HomeViewState].
  factory HomeViewState.initial() => const HomeViewState();

  /// Returns true if there is a current user.
  bool get hasUser => currentUser != null;

  /// Clears error and success messages.
  HomeViewState clearMessages() =>
      copyWith(errorMessage: null, successMessage: null);
}
