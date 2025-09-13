import 'package:feature_dashboard/src/presentation/viewmodels/home_view_state.dart';
import 'package:feature_dashboard/src/presentation/viewmodels/home_viewmodel.dart';
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
            title: const Text('Dashboard'),
            actions: [
              if (viewModel.hasUser)
                IconButton(
                  onPressed: viewModel.clearUser,
                  icon: const Icon(Icons.logout),
                  tooltip: 'Clear User',
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
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Loading user information...'),
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
                child: const Text('Retry'),
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
              const Text(
                'User Information:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              'Button clicked ${viewModel.buttonClickCount} times',
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
              child: const Text('Click Me!'),
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
            const Text(
              'Navigation Example',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/details'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Go to Details'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
