import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_view_state.freezed.dart';

@freezed
class SettingsViewState with _$SettingsViewState {
  const factory SettingsViewState({
    @Default(false) bool isLoading,
    String? errorMessage,
    String? successMessage,
  }) = _SettingsViewState;

  const SettingsViewState._();

  factory SettingsViewState.initial() => const SettingsViewState();

  SettingsViewState clearMessages() => copyWith(errorMessage: null, successMessage: null);
}
