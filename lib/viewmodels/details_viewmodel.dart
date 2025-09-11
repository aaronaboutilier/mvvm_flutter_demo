// lib/viewmodels/details_viewmodel.dart

import 'package:flutter/foundation.dart';
import '../core/core.dart' as core;
import '../features/details/application/usecases/add_detail_item.dart';
import '../features/details/application/usecases/clear_detail_items.dart';
import '../features/details/application/usecases/get_detail_items.dart';
import '../features/details/application/usecases/remove_detail_item.dart';
import '../features/details/application/usecases/reorder_detail_items.dart';
import '../core/di/locator.dart';
import '../features/details/domain/entities/detail_item.dart';

/// DetailsViewModel manages state and logic for the details screen
/// This demonstrates how each screen can have its own ViewModel
/// keeping concerns separated and making the app more maintainable
class DetailsViewModel extends ChangeNotifier {
  // Dependencies (temporary manual wiring; later via DI)
  final GetDetailItems _getItems;
  final AddDetailItem _addItemUc;
  final RemoveDetailItem _removeItemUc;
  final ClearDetailItems _clearItemsUc;
  final ReorderDetailItems _reorderItemsUc;

  DetailsViewModel()
      : _getItems = locator<GetDetailItems>(),
        _addItemUc = locator<AddDetailItem>(),
        _removeItemUc = locator<RemoveDetailItem>(),
        _clearItemsUc = locator<ClearDetailItems>(),
        _reorderItemsUc = locator<ReorderDetailItems>();

  // UI State
  String _selectedColor = 'Blue';
  List<DetailItem> _items = [];
  bool _isAddingItem = false;

  // Public getters to expose state
  String get selectedColor => _selectedColor;
  List<String> get items => List.unmodifiable(_items.map((e) => '${e.name} (${e.displayTime})'));
  bool get isAddingItem => _isAddingItem;
  
  // Available colors for selection
  static const List<String> availableColors = [
    'Red', 'Blue', 'Green', 'Yellow', 'Purple', 'Orange'
  ];

  // Computed properties
  int get itemCount => _items.length;
  bool get hasItems => _items.isNotEmpty;
  String get summaryText => hasItems 
      ? 'You have $itemCount items in $_selectedColor theme'
      : 'No items yet. Add some to get started!';

  /// Changes the selected color theme
  /// This shows how ViewModels handle simple state changes
  void selectColor(String color) {
    if (availableColors.contains(color) && color != _selectedColor) {
      _selectedColor = color;
      notifyListeners();
    }
  }

  /// Adds a new item to the list
  /// This demonstrates handling more complex operations with loading states
  Future<void> addItem(String itemName) async {
    if (itemName.trim().isEmpty) return;

    _isAddingItem = true;
    notifyListeners();

    try {
      final res = await _addItemUc(itemName);
      await _refreshItems();
      res.fold(
        failure: (_) {},
        success: (_) {},
      );
    } catch (error) {
      // In a real app, you'd handle errors appropriately
      debugPrint('Error adding item: $error');
    } finally {
      _isAddingItem = false;
      notifyListeners();
    }
  }

  /// Removes an item at the specified index
  Future<void> removeItem(int index) async {
    final res = await _removeItemUc(index);
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  /// Clears all items
  Future<void> clearAllItems() async {
    final res = await _clearItemsUc(const core.NoParams());
    await _refreshItems();
    res.fold(failure: (_) {}, success: (_) {});
  }

  /// Reorders items in the list
  /// This shows how to handle more complex list operations
  void reorderItems(int oldIndex, int newIndex) {
    () async {
      final res = await _reorderItemsUc(ReorderParams(oldIndex: oldIndex, newIndex: newIndex));
      await _refreshItems();
      res.fold(failure: (_) {}, success: (_) {});
    }();
  }

  // Private helper method
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

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}