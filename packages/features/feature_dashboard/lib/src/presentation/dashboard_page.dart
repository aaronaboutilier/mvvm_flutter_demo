import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:feature_dashboard/src/presentation/viewmodels/home_view_state.dart';
import 'package:feature_dashboard/src/presentation/viewmodels/home_viewmodel.dart';
import 'package:feature_settings/feature_settings.dart'
    show showSettingsOverlay;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Dashboard page composed from the Home feature UI.
class DashboardPage extends StatelessWidget {
  /// Creates a [DashboardPage].
  const DashboardPage({super.key});

  /// Builds the widget tree for the dashboard page.
  @override
  Widget build(BuildContext context) {
    return Provider<HomeViewModel>(
      create: (context) => GetIt.I<HomeViewModel>(),
      child: const _DashboardContent(),
    );
  }
}

/// Internal widget for dashboard content.
class _DashboardContent extends StatefulWidget {
  /// Creates a [_DashboardContent] widget.
  const _DashboardContent();

  /// Creates the state for [_DashboardContent].
  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

/// State for [_DashboardContent].
class _DashboardContentState extends State<_DashboardContent> {
  /// Initializes the state and loads the user.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadUser();
    });
  }

  /// Builds the widget tree for the dashboard content.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return StreamBuilder<HomeViewState>(
      stream: viewModel.stateStream,
      builder: (context, snapshot) {
        final _ = snapshot.data; // trigger rebuilds on state changes
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).dashboard),
            actions: [
              if (viewModel.hasUser)
                IconButton(
                  onPressed: viewModel.clearUser,
                  icon: const Icon(Icons.logout),
                  tooltip: AppLocalizations.of(context).clearUser,
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildWelcomeSection(viewModel),
                const SizedBox(height: 32),
                _buildUserInfoSection(viewModel),
                const SizedBox(height: 32),
                _buildButtonSection(context, viewModel),
                const SizedBox(height: 32),
                _buildNavigationSection(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the welcome section card.
  Widget _buildWelcomeSection(HomeViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              viewModel.hasUser ? Icons.person : Icons.person_outline,
              size: 48,
              color: viewModel.hasUser ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.welcomeMessage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the user info section card.
  Widget _buildUserInfoSection(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(AppLocalizations.of(context).loadingUserInformation),
            ],
          ),
        ),
      );
    }

    if (viewModel.errorMessage != null) {
      return Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(height: 8),
              Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: viewModel.loadUser,
                child: Text(AppLocalizations.of(context).retry),
              ),
            ],
          ),
        ),
      );
    }

    if (viewModel.currentUser != null) {
      final user = viewModel.currentUser!;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).userInformation,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('ID: ${user.id}'),
              Text('Name: ${user.name}'),
              Text('Email: ${user.email}'),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// Builds the button section card.
  Widget _buildButtonSection(BuildContext context, HomeViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(
                context,
              ).buttonClickedTimes(viewModel.buttonClickCount),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.onButtonPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: Text(AppLocalizations.of(context).clickMe),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the navigation section card.
  Widget _buildNavigationSection(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).navigationExample,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/details'),
              icon: const Icon(Icons.arrow_forward),
              label: Text(AppLocalizations.of(context).goToDetails),
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
}
