import '../../../../core/core.dart' as core;
import '../../application/usecases/add_detail_item.dart';
import '../../application/usecases/clear_detail_items.dart';
import '../../application/usecases/get_detail_items.dart';
import '../../application/usecases/remove_detail_item.dart';
import '../../application/usecases/reorder_detail_items.dart';
import '../../domain/entities/detail_item.dart';
import '../../../../core/core.dart';
import 'details_view_state.dart';

class DetailsViewModel extends ChangeNotifierViewModel<DetailsViewState> {
  final GetDetailItems _getItems;
  final AddDetailItem _addItemUc;
  final RemoveDetailItem _removeItemUc;
  final ClearDetailItems _clearItemsUc;
  final ReorderDetailItems _reorderItemsUc;

  DetailsViewModel({
    required GetDetailItems getItems,
    required AddDetailItem addItem,
    required RemoveDetailItem removeItem,
    required ClearDetailItems clearItems,
    required ReorderDetailItems reorderItems,
  })  : _getItems = getItems,
        _addItemUc = addItem,
        _removeItemUc = removeItem,
        _clearItemsUc = clearItems,
        _reorderItemsUc = reorderItems,
        super(DetailsViewState.initial());

  String get selectedColor => state.selectedColor;
  List<String> get items => state.displayItems;
  bool get isAddingItem => state.isAddingItem;
  bool get hasItems => state.hasItems;
  int get itemCount => state.itemCount;
  String get summaryText => state.summaryText;

  static const List<String> availableColors = [
    'Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'
  ];

  void selectColor(String color) {
    if (availableColors.contains(color) && color != state.selectedColor) {
      updateState(state.copyWith(selectedColor: color));
    }
  }

  Future<void> addItem(String itemName) async {
    if (itemName.trim().isEmpty) return;
    updateState(state.copyWith(isAddingItem: true));
    try {
      final res = await _addItemUc(itemName);
      await _refreshItems();
      res.fold(failure: (_) {}, success: (_) {});
    } finally {
      // handled below
    }
    updateState(state.copyWith(isAddingItem: false));
  }

  Future<void> removeItem(int index) async {
    final res = await _removeItemUc(index);
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  Future<void> clearAllItems() async {
    final res = await _clearItemsUc(const core.NoParams());
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  void reorderItems(int oldIndex, int newIndex) {
    () async {
  final res = await _reorderItemsUc(ReorderParams(oldIndex: oldIndex, newIndex: newIndex));
  await _refreshItems();
  res.fold(failure: (_) {}, success: (_) {});
    }();
  }

  Future<void> _refreshItems() async {
    final res = await _getItems(const core.NoParams());
    res.fold(
      failure: (_) {},
      success: (list) {
  updateState(state.copyWith(items: List<DetailItem>.from(list)));
      },
    );
  }

  Future<void> load() => _refreshItems();
}
