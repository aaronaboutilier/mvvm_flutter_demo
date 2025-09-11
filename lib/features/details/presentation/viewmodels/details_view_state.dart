import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/detail_item.dart';

part 'details_view_state.freezed.dart';

@freezed
class DetailsViewState with _$DetailsViewState {
  const factory DetailsViewState({
    @Default('Blue') String selectedColor,
    @Default(<DetailItem>[]) List<DetailItem> items,
    @Default(false) bool isAddingItem,
    @Default(false) bool isLoading,
    String? errorMessage,
    String? successMessage,
  }) = _DetailsViewState;

  const DetailsViewState._();

  factory DetailsViewState.initial() => const DetailsViewState();

  int get itemCount => items.length;
  bool get hasItems => items.isNotEmpty;
  List<String> get displayItems =>
      List.unmodifiable(items.map((e) => '${e.name} (${e.displayTime})'));
  String get summaryText => hasItems
      ? 'You have $itemCount items in $selectedColor theme'
      : 'No items yet. Add some to get started!';

  DetailsViewState clearMessages() =>
      copyWith(errorMessage: null, successMessage: null);
}
