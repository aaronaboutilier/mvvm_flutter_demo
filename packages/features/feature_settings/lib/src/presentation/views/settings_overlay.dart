import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:feature_settings/src/presentation/viewmodels/settings_viewmodel.dart';
import 'package:feature_settings/src/presentation/widgets/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

/// Shows the Settings UI as a full-screen overlay (dialog) without changing
/// the app route or URL.
Future<void> showSettingsOverlay(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => const Dialog.fullscreen(child: _SettingsOverlay()),
  );
}

class _SettingsOverlay extends StatelessWidget {
  const _SettingsOverlay();

  @override
  Widget build(BuildContext context) {
    return Provider<SettingsViewModel>(
      create: (_) => GetIt.I<SettingsViewModel>(),
      child: const _SettingsOverlayContent(),
    );
  }
}

class _SettingsOverlayContent extends StatelessWidget {
  const _SettingsOverlayContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: AppLocalizations.of(context).close,
        ),
      ),
      body: const SettingsBody(),
    );
  }
}
