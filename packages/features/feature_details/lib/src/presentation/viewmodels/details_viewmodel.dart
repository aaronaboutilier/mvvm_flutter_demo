import 'package:core_foundation/core/core.dart' as core;
import 'package:core_foundation/core/core.dart';
import 'package:feature_details/src/application/usecases/add_detail_item.dart';
import 'package:feature_details/src/application/usecases/clear_detail_items.dart';
import 'package:feature_details/src/application/usecases/get_detail_items.dart';
import 'package:feature_details/src/application/usecases/remove_detail_item.dart';
import 'package:feature_details/src/application/usecases/reorder_detail_items.dart';
import 'package:feature_details/src/domain/entities/detail_item.dart';
import 'package:feature_details/src/presentation/viewmodels/details_view_state.dart';

/// ViewModel for the details view.
class DetailsViewModel extends ChangeNotifierViewModel<DetailsViewState> {
  /// Creates a [DetailsViewModel] with required use cases.
  DetailsViewModel({
    required GetDetailItems getItems,
    required AddDetailItem addItem,
    required RemoveDetailItem removeItem,
    required ClearDetailItems clearItems,
    required ReorderDetailItems reorderItems,
  }) : _getItems = getItems,
       _addItemUc = addItem,
       _removeItemUc = removeItem,
       _clearItemsUc = clearItems,
       _reorderItemsUc = reorderItems,
       super(DetailsViewState.initial());

  /// Use case for getting detail items.
  final GetDetailItems _getItems;

  /// Use case for adding a detail item.
  final AddDetailItem _addItemUc;

  /// Use case for removing a detail item.
  final RemoveDetailItem _removeItemUc;

  /// Use case for clearing all detail items.
  final ClearDetailItems _clearItemsUc;

  /// Use case for reordering detail items.
  final ReorderDetailItems _reorderItemsUc;

  /// The selected color.
  // Theme color is now managed globally in Settings via core_design_system.
  // Kept for backward compatibility removal; no longer used.

  /// The list of display items.
  List<String> get items => state.displayItems;

  /// Whether an item is being added.
  bool get isAddingItem => state.isAddingItem;

  /// Whether there are items.
  bool get hasItems => state.hasItems;

  /// The number of items.
  int get itemCount => state.itemCount;

  /// The summary text for the view.
  String get summaryText => state.summaryText;

  // Removed local color selection and available colors.

  /// Adds a new item with the given [itemName].
  Future<void> addItem(String itemName) async {
    if (itemName.trim().isEmpty) return;
    updateState(state.copyWith(isAddingItem: true));
    try {
      final res = await _addItemUc(itemName);
      await _refreshItems();
      res.fold(failure: (_) {}, success: (_) {});
    } finally {
      updateState(state.copyWith(isAddingItem: false));
    }
  }

  /// Removes the item at the given [index].
  Future<void> removeItem(int index) async {
    final res = await _removeItemUc(index);
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  /// Clears all items.
  Future<void> clearAllItems() async {
    final res = await _clearItemsUc(const core.NoParams());
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  /// Reorders items from [oldIndex] to [newIndex].
  void reorderItems(int oldIndex, int newIndex) {
    () async {
      final res = await _reorderItemsUc(
        ReorderParams(oldIndex: oldIndex, newIndex: newIndex),
      );
      await _refreshItems();
      res.fold(failure: (_) {}, success: (_) {});
    }();
  }

  /// Refreshes the items from the repository.
  Future<void> _refreshItems() async {
    final res = await _getItems(const core.NoParams());
    res.fold(
      failure: (_) {},
      success: (list) {
        updateState(state.copyWith(items: List<DetailItem>.from(list)));
      },
    );
  }

  /// Loads the items.
  Future<void> load() => _refreshItems();
}
