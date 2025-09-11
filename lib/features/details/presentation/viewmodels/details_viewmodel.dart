import '../../../../core/core.dart' as core;
import '../../application/usecases/add_detail_item.dart';
import '../../application/usecases/clear_detail_items.dart';
import '../../application/usecases/get_detail_items.dart';
import '../../application/usecases/remove_detail_item.dart';
import '../../application/usecases/reorder_detail_items.dart';
import '../../domain/entities/detail_item.dart';
import '../../../../core/core.dart';

class DetailsViewModel extends BaseViewModel {
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
        _reorderItemsUc = reorderItems;

  String _selectedColor = 'Blue';
  List<DetailItem> _items = [];
  bool _isAddingItem = false;

  String get selectedColor => _selectedColor;
  List<String> get items => List.unmodifiable(_items.map((e) => '${e.name} (${e.displayTime})'));
  bool get isAddingItem => _isAddingItem;

  static const List<String> availableColors = [
    'Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'
  ];

  int get itemCount => _items.length;
  bool get hasItems => _items.isNotEmpty;
  String get summaryText => hasItems
      ? 'You have $itemCount items in $_selectedColor theme'
      : 'No items yet. Add some to get started!';

  void selectColor(String color) {
    if (availableColors.contains(color) && color != _selectedColor) {
      _selectedColor = color;
      notifyListeners();
    }
  }

  Future<void> addItem(String itemName) async {
    if (itemName.trim().isEmpty) return;
    _isAddingItem = true;
    notifyListeners();
    await performOperation('Adding item', () async {
      final res = await _addItemUc(itemName);
      await _refreshItems();
      res.fold(failure: (_) {}, success: (_) {});
    });
    _isAddingItem = false;
    notifyListeners();
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
      await performOperation('Reordering items', () async {
        final res = await _reorderItemsUc(ReorderParams(oldIndex: oldIndex, newIndex: newIndex));
        await _refreshItems();
        res.fold(failure: (_) {}, success: (_) {});
      });
    }();
  }

  Future<void> _refreshItems() async {
    final res = await _getItems(const core.NoParams());
    res.fold(
      failure: (_) {},
      success: (list) {
        _items = List<DetailItem>.from(list);
      },
    );
    notifyListeners();
  }

  Future<void> load() => _refreshItems();
}
