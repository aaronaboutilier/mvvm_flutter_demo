import '../../domain/entities/detail_item.dart';

class DetailsViewState {
  final String selectedColor;
  final List<DetailItem> items;
  final bool isAddingItem;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const DetailsViewState({
    this.selectedColor = 'Blue',
    this.items = const <DetailItem>[],
    this.isAddingItem = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  factory DetailsViewState.initial() => const DetailsViewState();

  int get itemCount => items.length;
  bool get hasItems => items.isNotEmpty;
  List<String> get displayItems =>
      List.unmodifiable(items.map((DetailItem e) => '${e.name} (${e.displayTime})'));
  String get summaryText => hasItems
      ? 'You have $itemCount items in $selectedColor theme'
      : 'No items yet. Add some to get started!';

  DetailsViewState copyWith({
    String? selectedColor,
    List<DetailItem>? items,
    bool? isAddingItem,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return DetailsViewState(
      selectedColor: selectedColor ?? this.selectedColor,
      items: items ?? this.items,
      isAddingItem: isAddingItem ?? this.isAddingItem,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  DetailsViewState clearMessages() =>
      copyWith(errorMessage: null, successMessage: null);
}
