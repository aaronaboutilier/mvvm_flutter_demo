import 'package:feature_details/src/domain/entities/detail_item.dart';

/// State for the details view.
class DetailsViewState {
  /// Creates a [DetailsViewState].
  const DetailsViewState({
    this.items = const <DetailItem>[],
    this.isAddingItem = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  /// Returns the initial [DetailsViewState].
  factory DetailsViewState.initial() => const DetailsViewState();

  // Theme color is now controlled by Settings; no local color state.

  /// The list of detail items.
  final List<DetailItem> items;

  /// Whether an item is being added.
  final bool isAddingItem;

  /// Whether the view is loading.
  final bool isLoading;

  /// Error message, if any.
  final String? errorMessage;

  /// Success message, if any.
  final String? successMessage;

  /// The number of items.
  int get itemCount => items.length;

  /// Returns true if there are items.
  bool get hasItems => items.isNotEmpty;

  /// Returns a list of display strings for the items.
  List<String> get displayItems => List.unmodifiable(
    items.map((DetailItem e) => '${e.name} (${e.displayTime})'),
  );

  /// Returns a summary text for the view.
  String get summaryText => hasItems
      ? 'You have $itemCount items'
      : 'No items yet. Add some to get started!';

  /// Returns a copy of this state with updated fields.
  DetailsViewState copyWith({
    List<DetailItem>? items,
    bool? isAddingItem,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return DetailsViewState(
      items: items ?? this.items,
      isAddingItem: isAddingItem ?? this.isAddingItem,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  /// Clears error and success messages.
  DetailsViewState clearMessages() => copyWith();
}
