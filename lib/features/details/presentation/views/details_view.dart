import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/locator.dart';
import '../viewmodels/details_viewmodel.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<DetailsViewModel>(),
      child: const _DetailsContent(),
    );
  }
}

class _DetailsContent extends StatefulWidget {
  const _DetailsContent();

  @override
  State<_DetailsContent> createState() => _DetailsContentState();
}

class _DetailsContentState extends State<_DetailsContent> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsViewModel>().load();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MVVM Demo - Details'),
            backgroundColor: _getThemeColor(viewModel.selectedColor),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
            actions: [
              if (viewModel.hasItems)
                IconButton(
                  onPressed: () => _showClearConfirmation(context, viewModel),
                  icon: const Icon(Icons.clear_all),
                  tooltip: 'Clear All Items',
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildColorSelectionSection(viewModel),
                const SizedBox(height: 24),
                _buildSummarySection(viewModel),
                const SizedBox(height: 24),
                _buildAddItemSection(context, viewModel),
                const SizedBox(height: 24),
                _buildItemsListSection(viewModel),
                const SizedBox(height: 24),
                _buildNavigationSection(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorSelectionSection(DetailsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Theme Color:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              children: DetailsViewModel.availableColors.map((color) {
                final isSelected = color == viewModel.selectedColor;
                return FilterChip(
                  label: Text(color),
                  selected: isSelected,
                  selectedColor: _getThemeColor(color).withValues(alpha: 0.3),
                  onSelected: (selected) {
                    if (selected) {
                      viewModel.selectColor(color);
                    }
                  },
                  avatar: CircleAvatar(
                    backgroundColor: _getThemeColor(color),
                    radius: 8,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection(DetailsViewModel viewModel) {
    return Card(
      color: _getThemeColor(viewModel.selectedColor).withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              viewModel.hasItems ? Icons.inventory : Icons.inventory_2_outlined,
              size: 32,
              color: _getThemeColor(viewModel.selectedColor),
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.summaryText,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            if (viewModel.hasItems) ...[
              const SizedBox(height: 8),
              Text(
                'Items: ${viewModel.itemCount}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAddItemSection(BuildContext context, DetailsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Item:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter item name...',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !viewModel.isAddingItem,
                    onSubmitted: (value) => _addItem(viewModel),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: viewModel.isAddingItem ? null : () => _addItem(viewModel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getThemeColor(viewModel.selectedColor),
                    foregroundColor: Colors.white,
                  ),
                  child: viewModel.isAddingItem
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsListSection(DetailsViewModel viewModel) {
    if (!viewModel.hasItems) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Icon(
                Icons.inbox,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No items yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Add your first item above to get started!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Items (${viewModel.itemCount}):',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: math.min(viewModel.itemCount * 72.0, 300.0),
              child: ReorderableListView.builder(
                itemCount: viewModel.itemCount,
                onReorder: viewModel.reorderItems,
                itemBuilder: (context, index) {
                  final item = viewModel.items[index];
                  return ListTile(
                    key: ValueKey(item),
                    leading: CircleAvatar(
                      backgroundColor: _getThemeColor(viewModel.selectedColor),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => viewModel.removeItem(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Navigation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem(DetailsViewModel viewModel) {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      viewModel.addItem(text);
      _textController.clear();
    }
  }

  void _showClearConfirmation(BuildContext context, DetailsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Items'),
        content: const Text('Are you sure you want to remove all items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              viewModel.clearAllItems();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Color _getThemeColor(String colorName) {
    switch (colorName) {
      case 'Red':
        return Colors.red;
      case 'Blue':
        return Colors.blue;
      case 'Green':
        return Colors.green;
      case 'Yellow':
        return Colors.orange;
      case 'Purple':
        return Colors.purple;
      case 'Orange':
        return Colors.deepOrange;
      default:
        return Colors.blue;
    }
  }
}
