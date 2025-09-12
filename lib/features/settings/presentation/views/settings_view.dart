import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:feature_dashboard/feature_dashboard.dart' show DashboardRoutes;
import 'package:mvvm_flutter_demo/core/localization/localization.dart';
import 'package:mvvm_flutter_demo/core/configuration/configuration.dart';
import '../../../../core/di/locator.dart';
import '../viewmodels/settings_viewmodel.dart';
import '../viewmodels/settings_view_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
  return Provider<SettingsViewModel>(
      create: (context) => locator<SettingsViewModel>(),
      child: const _SettingsContent(),
    );
  }
}

class _SettingsContent extends StatefulWidget {
  const _SettingsContent();

  @override
  State<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<_SettingsContent> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
  final vm = context.read<SettingsViewModel>();
  return Consumer<ConfigService>(
      builder: (context, configService, child) {
        final config = configService.currentConfig;
        return StreamBuilder<SettingsViewState>(
          stream: vm.stateStream,
          builder: (context, snapshot) {
            final _ = snapshot.data; // rebuild on state
            return Scaffold(
          appBar: AppBar(
            title: Text(localizations.settingsTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(DashboardRoutes.path),
              tooltip: localizations.backToHome,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemeSection(context, localizations, config, vm),
                const SizedBox(height: 24),
                _buildAccessibilitySection(context, localizations, config, vm),
                const SizedBox(height: 24),
                _buildLanguageSection(context, localizations, config, vm),
                const SizedBox(height: 24),
                if (config.features.enableDataExport)
                  _buildAdvancedSection(context, localizations, config, vm),
                const SizedBox(height: 24),
                _buildBrandSection(context, localizations, config),
              ],
            ),
          ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    AppLocalizations localizations,
    AppConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.themeSettings,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(localizations.themeMode, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(value: ThemeMode.light, label: Text(localizations.lightTheme), icon: const Icon(Icons.light_mode)),
                ButtonSegment(value: ThemeMode.dark, label: Text(localizations.darkTheme), icon: const Icon(Icons.dark_mode)),
                ButtonSegment(value: ThemeMode.system, label: Text(localizations.systemTheme), icon: const Icon(Icons.auto_mode)),
              ],
              selected: {config.theme.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) => viewModel.updateThemeMode(selection.first),
            ),
            const SizedBox(height: 16),
            Text(localizations.textSize, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(localizations.textSizeSmall, style: Theme.of(context).textTheme.bodySmall),
                Expanded(
                  child: Slider(
                    value: config.theme.textScaleFactor,
                    min: 0.8,
                    max: 2.0,
                    divisions: 12,
                    label: '${(config.theme.textScaleFactor * 100).round()}%',
                    onChanged: viewModel.updateTextScaleFactor,
                    semanticFormatterCallback: (value) => '${(value * 100).round()} percent text size',
                  ),
                ),
                Text(localizations.textSizeLarge, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilitySection(
    BuildContext context,
    AppLocalizations localizations,
    AppConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.accessibility, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(localizations.accessibilitySettings, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(localizations.reduceAnimations),
              subtitle: Text(localizations.reduceAnimationsDescription),
              value: config.accessibility.reduceAnimations,
              onChanged: viewModel.updateReduceAnimations,
              secondary: const Icon(Icons.motion_photos_off),
            ),
            SwitchListTile(
              title: Text(localizations.highContrast),
              subtitle: Text(localizations.highContrastDescription),
              value: config.accessibility.increasedContrast,
              onChanged: viewModel.updateHighContrast,
              secondary: const Icon(Icons.contrast),
            ),
            SwitchListTile(
              title: Text(localizations.largerTouchTargets),
              subtitle: Text(localizations.largerTouchTargetsDescription),
              value: config.accessibility.largerTouchTargets,
              onChanged: viewModel.updateLargerTouchTargets,
              secondary: const Icon(Icons.touch_app),
            ),
            SwitchListTile(
              title: Text(localizations.voiceGuidance),
              subtitle: Text(localizations.voiceGuidanceDescription),
              value: config.accessibility.enableVoiceGuidance,
              onChanged: viewModel.updateVoiceGuidance,
              secondary: const Icon(Icons.record_voice_over),
            ),
            SwitchListTile(
              title: Text(localizations.hapticFeedback),
              subtitle: Text(localizations.hapticFeedbackDescription),
              value: config.accessibility.enableHapticFeedback,
              onChanged: viewModel.updateHapticFeedback,
              secondary: const Icon(Icons.vibration),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    AppLocalizations localizations,
    AppConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(localizations.languageSettings, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(localizations.useDeviceLanguage),
              subtitle: Text(localizations.useDeviceLanguageDescription),
              value: config.localization.useDeviceLocale,
              onChanged: viewModel.updateUseDeviceLocale,
              secondary: const Icon(Icons.smartphone),
            ),
            if (!config.localization.useDeviceLocale) ...[
              const SizedBox(height: 16),
              Text(localizations.selectLanguage, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: config.localization.languageCode,
                decoration: InputDecoration(border: const OutlineInputBorder(), labelText: localizations.language),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'es', child: Text('Español')),
                  DropdownMenuItem(value: 'fr', child: Text('Français')),
                  DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                  DropdownMenuItem(value: 'ja', child: Text('日本語')),
                ],
                onChanged: (value) {
                  if (value != null) viewModel.updateLanguageCode(value);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSection(
    BuildContext context,
    AppLocalizations localizations,
    AppConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings_applications, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(localizations.advancedSettings, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(localizations.exportSettings),
              subtitle: Text(localizations.exportSettingsDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.exportConfiguration,
            ),
            ListTile(
              leading: Icon(Icons.restore, color: Theme.of(context).colorScheme.error),
              title: Text(localizations.resetToDefaults, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              subtitle: Text(localizations.resetToDefaultsDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showResetConfirmation(context, localizations, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection(BuildContext context, AppLocalizations localizations, AppConfig config) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.business, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(localizations.aboutApp, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(localizations.appName, config.brand.appName),
            _buildInfoRow(localizations.version, '1.0.0'),
            _buildInfoRow(localizations.website, config.brand.websiteUrl),
            _buildInfoRow(localizations.support, config.brand.supportEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showResetConfirmation(BuildContext context, AppLocalizations localizations, SettingsViewModel viewModel) {
  showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.resetToDefaults),
        content: Text(localizations.resetConfirmation),
        actions: [
      TextButton(onPressed: () => Navigator.of(context).pop<void>(), child: Text(localizations.cancel)),
          TextButton(
            onPressed: () {
              viewModel.resetToDefaults();
        Navigator.of(context).pop<void>();
            },
            child: Text(localizations.reset),
          ),
        ],
      ),
    );
  }
}
