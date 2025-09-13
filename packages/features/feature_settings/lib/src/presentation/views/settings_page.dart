import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:feature_dashboard/feature_dashboard.dart' show DashboardRoutes;
import 'package:feature_settings/src/presentation/viewmodels/settings_viewmodel.dart';
import 'package:feature_settings/src/presentation/widgets/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The Settings page for the Settings feature.
class SettingsPage extends StatelessWidget {
  /// Creates a SettingsPage.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SettingsViewModel>(
      create: (context) => GetIt.I<SettingsViewModel>(),
      child: const _SettingsPageScaffold(),
    );
  }
}

class _SettingsPageScaffold extends StatelessWidget {
  const _SettingsPageScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(DashboardRoutes.path),
          tooltip: AppLocalizations.of(context).backToHome,
        ),
      ),
      body: const SettingsBody(),
    );
  }
}
