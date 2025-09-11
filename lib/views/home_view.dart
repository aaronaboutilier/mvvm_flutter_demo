// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:mvvm_flutter_demo/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/home_viewmodel.dart';
import '../core/di/locator.dart';

/// HomeView represents the UI layer of our MVVM architecture
/// This View should contain minimal logic - just UI layout and user interaction handling
/// All business logic and state management is handled by the HomeViewModel
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // We wrap the entire view with ChangeNotifierProvider to provide the ViewModel
    // to this widget tree. This is how we connect the View to the ViewModel in MVVM.
    return ChangeNotifierProvider(
      create: (context) => locator<HomeViewModel>(),
      child: const _HomeContent(),
    );
  }
}

/// Separate the content into its own widget to cleanly separate provider setup
/// from the actual UI content. This is a good practice for maintainability.
class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  @override
  void initState() {
    super.initState();
    // Load initial data when the view first appears
    // We use addPostFrameCallback to ensure the widget tree is built before calling the ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Consumer<HomeViewModel> listens to changes in the ViewModel
    // When notifyListeners() is called in the ViewModel, this widget rebuilds
    // This is the core reactive mechanism in Flutter MVVM
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MVVM Demo - Home'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // Show a clear button when user is loaded
              if (viewModel.hasUser)
                IconButton(
                  onPressed: viewModel.clearUser,
                  icon: const Icon(Icons.logout),
                  tooltip: 'Clear User',
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome message section
                _buildWelcomeSection(viewModel),
                
                const SizedBox(height: 32),
                
                // User information section
                _buildUserInfoSection(viewModel),
                
                const SizedBox(height: 32),
                
                // Button interaction section
                _buildButtonSection(context, viewModel),
                
                const SizedBox(height: 32),
                
                // Navigation section
                _buildNavigationSection(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the welcome message section
  /// Notice how the View just displays data from the ViewModel without any logic
  Widget _buildWelcomeSection(HomeViewModel viewModel) {
    final localizations = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              viewModel.hasUser ? Icons.person : Icons.person_outline,
              size: 48,
              color: viewModel.hasUser ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.hasUser 
                  ? localizations.welcomeBack(viewModel.currentUser!.name)
                  : localizations.welcomeGuest,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the user information section with loading and error states
  /// This demonstrates how MVVM handles different UI states elegantly
  Widget _buildUserInfoSection(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
          padding: const EdgeInsets.all(16.0),
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
          padding: const EdgeInsets.all(16.0),
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

  /// Builds the button interaction section
  /// Shows how user interactions are passed to the ViewModel
  Widget _buildButtonSection(BuildContext context, HomeViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Button clicked ${viewModel.buttonClickCount} times',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // Notice how we just call the ViewModel method
              // No business logic in the View!
              onPressed: viewModel.onButtonPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Click Me!'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the navigation section
  /// This shows how navigation can be triggered from user interactions
  Widget _buildNavigationSection(BuildContext context, HomeViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Navigation Example',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // In MVVM, navigation can be handled in different ways:
                // 1. Directly in the View (simple cases like this)
                // 2. Through the ViewModel (complex navigation logic)
                // 3. Using a navigation service (advanced scenarios)
                context.go('/details');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Go to Details'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}