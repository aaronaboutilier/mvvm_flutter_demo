import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../core/di/locator.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<HomeViewModel>(),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent();

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('MVVM Demo - Home'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            padding: const EdgeInsets.all(16.0),
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
              onPressed: () => context.go('/details'),
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
