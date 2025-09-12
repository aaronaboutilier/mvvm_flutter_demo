import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart' as domain;

part 'home_view_state.freezed.dart';

@freezed
class HomeViewState with _$HomeViewState {
  const factory HomeViewState({
    domain.User? currentUser,
    @Default(0) int buttonClickCount,
    @Default(false) bool isLoading,
    String? errorMessage,
    String? successMessage,
  }) = _HomeViewState;

  const HomeViewState._();

  factory HomeViewState.initial() => const HomeViewState();

  bool get hasUser => currentUser != null;

  HomeViewState clearMessages() => copyWith(errorMessage: null, successMessage: null);
}
