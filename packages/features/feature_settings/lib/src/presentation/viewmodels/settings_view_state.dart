/// UI state for the Settings screen.
class SettingsViewState {
  /// Creates a [SettingsViewState].
  const SettingsViewState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  /// Initial/default state.
  factory SettingsViewState.initial() => const SettingsViewState();

  /// Whether an async operation is currently in progress.
  final bool isLoading;

  /// Optional error message to display.
  final String? errorMessage;

  /// Optional success message to display.
  final String? successMessage;

  /// Returns a copy with the provided fields updated.
  SettingsViewState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) => SettingsViewState(
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    successMessage: successMessage ?? this.successMessage,
  );

  /// Returns a copy with messages preserved (can be extended in the future).
  SettingsViewState clearMessages() => copyWith();
}
