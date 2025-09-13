import 'dart:math' as math;

import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:feature_dashboard/feature_dashboard.dart' show DashboardRoutes;
import 'package:feature_details/src/presentation/viewmodels/details_view_state.dart';
import 'package:feature_details/src/presentation/viewmodels/details_viewmodel.dart';
import 'package:feature_settings/feature_settings.dart'
    show showSettingsOverlay;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Details page for managing detail items.
class DetailsPage extends StatelessWidget {
  /// Creates a [DetailsPage].
  const DetailsPage({super.key});

  /// Builds the widget tree for the details page.
  @override
  Widget build(BuildContext context) {
    return Provider<DetailsViewModel>(
      create: (context) => GetIt.I<DetailsViewModel>(),
      child: const _DetailsContent(),
    );
  }
}

/// Internal widget for details content.
class _DetailsContent extends StatefulWidget {
  /// Creates a [_DetailsContent] widget.
  const _DetailsContent();

  /// Creates the state for [_DetailsContent].
  @override
  State<_DetailsContent> createState() => _DetailsContentState();
}

/// State for [_DetailsContent].
class _DetailsContentState extends State<_DetailsContent> {
  /// Controller for the item name text field.
  final TextEditingController _textController = TextEditingController();

  /// Initializes the state and loads the items.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailsViewModel>().load();
    });
  }

  /// Disposes the text controller.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Builds the widget tree for the details content.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<DetailsViewModel>();
    return StreamBuilder<DetailsViewState>(
      stream: viewModel.stateStream,
      builder: (context, snapshot) {
        final _ = snapshot.data; // trigger rebuilds
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).detailsTitle),
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(DashboardRoutes.path),
            ),
            actions: [
              if (viewModel.hasItems)
                IconButton(
                  onPressed: () => _showClearConfirmation(context, viewModel),
                  icon: const Icon(Icons.clear_all),
                  tooltip: AppLocalizations.of(context).clearAllItems,
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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

  /// Builds the summary section card.
  Widget _buildSummarySection(DetailsViewModel viewModel) {
    return Card(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              viewModel.hasItems ? Icons.inventory : Icons.inventory_2_outlined,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
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
                AppLocalizations.of(context).itemsCount(viewModel.itemCount),
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds the add item section card.
  Widget _buildAddItemSection(
    BuildContext context,
    DetailsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).addNewItem,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).enterItemNameHint,
                      border: const OutlineInputBorder(),
                    ),
                    enabled: !viewModel.isAddingItem,
                    onSubmitted: (value) => _addItem(viewModel),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: viewModel.isAddingItem
                      ? null
                      : () => _addItem(viewModel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: viewModel.isAddingItem
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
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

  /// Builds the items list section card.
  Widget _buildItemsListSection(DetailsViewModel viewModel) {
    if (!viewModel.hasItems) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.inbox, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context).noItemsYet,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).addFirstItemHelp,
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).yourItemsCount(viewModel.itemCount),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: math.min(viewModel.itemCount * 72.0, 300),
              child: ReorderableListView.builder(
                itemCount: viewModel.itemCount,
                onReorder: viewModel.reorderItems,
                itemBuilder: (context, index) {
                  final item = viewModel.items[index];
                  return ListTile(
                    key: ValueKey(item),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
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

  /// Builds the navigation section card.
  Widget _buildNavigationSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).navigation,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go(DashboardRoutes.path),
              icon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context).backToHome),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => showSettingsOverlay(context),
              icon: const Icon(Icons.settings),
              label: Text(AppLocalizations.of(context).openSettings),
            ),
          ],
        ),
      ),
    );
  }

  /// Adds a new item using the text field value.
  void _addItem(DetailsViewModel viewModel) {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      viewModel.addItem(text);
      _textController.clear();
    }
  }

  /// Shows a confirmation dialog to clear all items.
  void _showClearConfirmation(
    BuildContext context,
    DetailsViewModel viewModel,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).clearAllItems),
        content: Text(AppLocalizations.of(context).clearAllConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              viewModel.clearAllItems();
              Navigator.of(context).pop<void>();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context).clearAll),
          ),
        ],
      ),
    );
  }
}
