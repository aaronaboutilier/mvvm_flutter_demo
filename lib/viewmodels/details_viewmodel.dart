// lib/viewmodels/details_viewmodel.dart

import 'package:flutter/foundation.dart';

/// DetailsViewModel manages state and logic for the details screen
/// This demonstrates how each screen can have its own ViewModel
/// keeping concerns separated and making the app more maintainable
class DetailsViewModel extends ChangeNotifier {
  // State for demonstration purposes
  String _selectedColor = 'Blue';
  List<String> _items = [];
  bool _isAddingItem = false;

  // Public getters to expose state
  String get selectedColor => _selectedColor;
  List<String> get items => List.unmodifiable(_items); // Return immutable copy
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
      // Simulate some processing time (like saving to a database)
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Add the item with a timestamp to make it unique
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _items.add('$itemName (${_formatTimestamp(timestamp)})');
      
    } catch (error) {
      // In a real app, you'd handle errors appropriately
      debugPrint('Error adding item: $error');
    } finally {
      _isAddingItem = false;
      notifyListeners();
    }
  }

  /// Removes an item at the specified index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  /// Clears all items
  void clearAllItems() {
    if (_items.isNotEmpty) {
      _items.clear();
      notifyListeners();
    }
  }

  /// Reorders items in the list
  /// This shows how to handle more complex list operations
  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    
    if (oldIndex >= 0 && oldIndex < _items.length && 
        newIndex >= 0 && newIndex < _items.length) {
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      notifyListeners();
    }
  }

  // Private helper method
  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}