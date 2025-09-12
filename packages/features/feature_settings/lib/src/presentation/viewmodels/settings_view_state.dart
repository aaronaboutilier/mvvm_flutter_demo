class SettingsViewState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const SettingsViewState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  factory SettingsViewState.initial() => const SettingsViewState();

  SettingsViewState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) => SettingsViewState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
      );

  SettingsViewState clearMessages() => copyWith(errorMessage: null, successMessage: null);
}
