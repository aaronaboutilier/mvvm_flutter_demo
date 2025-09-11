// lib/views/settings_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../generated/l10n/app_localizations.dart';
import '../services/config_service.dart';
import '../models/app_config.dart';
import '../viewmodels/settings_viewmodel.dart';
import '../core/di/locator.dart';

/// SettingsView demonstrates how configuration management integrates
/// with your MVVM architecture. This view shows how users can customize
/// their experience while respecting brand constraints and feature flags.
/// 
/// Notice how the View remains focused on UI concerns while the ViewModel
/// handles the business logic of managing configuration changes.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
    
    return Consumer2<SettingsViewModel, ConfigService>(
      builder: (context, settingsViewModel, configService, child) {
        final config = configService.currentConfig;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.settingsTitle),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
              tooltip: localizations.backToHome,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Settings Section
                _buildThemeSection(context, localizations, config, settingsViewModel),
                
                const SizedBox(height: 24),
                
                // Accessibility Settings Section
                _buildAccessibilitySection(context, localizations, config, settingsViewModel),
                
                const SizedBox(height: 24),
                
                // Language Settings Section
                _buildLanguageSection(context, localizations, config, settingsViewModel),
                
                const SizedBox(height: 24),
                
                // Advanced Settings Section (feature flag controlled)
                if (config.features.enableDataExport)
                  _buildAdvancedSection(context, localizations, config, settingsViewModel),
                
                const SizedBox(height: 24),
                
                // Brand Information Section (shows white-label info)
                _buildBrandSection(context, localizations, config),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the theme customization section
  /// This demonstrates how user preferences interact with brand constraints
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
            
            // Theme mode selection
            Text(
              localizations.themeMode,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(localizations.lightTheme),
                  icon: const Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(localizations.darkTheme),
                  icon: const Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(localizations.systemTheme),
                  icon: const Icon(Icons.auto_mode),
                ),
              ],
              selected: {config.theme.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) {
                viewModel.updateThemeMode(selection.first);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Text scale factor slider
            Text(
              localizations.textSize,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  localizations.textSizeSmall,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Expanded(
                  child: Slider(
                    value: config.theme.textScaleFactor,
                    min: 0.8,
                    max: 2.0,
                    divisions: 12,
                    label: '${(config.theme.textScaleFactor * 100).round()}%',
                    onChanged: viewModel.updateTextScaleFactor,
                    semanticFormatterCallback: (value) {
                      return '${(value * 100).round()} percent text size';
                    },
                  ),
                ),
                Text(
                  localizations.textSizeLarge,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the accessibility settings section
  /// This shows how accessibility preferences are managed through MVVM
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
                Icon(
                  Icons.accessibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.accessibilitySettings,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Reduce animations toggle
            SwitchListTile(
              title: Text(localizations.reduceAnimations),
              subtitle: Text(localizations.reduceAnimationsDescription),
              value: config.accessibility.reduceAnimations,
              onChanged: viewModel.updateReduceAnimations,
              secondary: const Icon(Icons.motion_photos_off),
            ),
            
            // High contrast toggle
            SwitchListTile(
              title: Text(localizations.highContrast),
              subtitle: Text(localizations.highContrastDescription),
              value: config.accessibility.increasedContrast,
              onChanged: viewModel.updateHighContrast,
              secondary: const Icon(Icons.contrast),
            ),
            
            // Larger touch targets toggle
            SwitchListTile(
              title: Text(localizations.largerTouchTargets),
              subtitle: Text(localizations.largerTouchTargetsDescription),
              value: config.accessibility.largerTouchTargets,
              onChanged: viewModel.updateLargerTouchTargets,
              secondary: const Icon(Icons.touch_app),
            ),
            
            // Voice guidance toggle
            SwitchListTile(
              title: Text(localizations.voiceGuidance),
              subtitle: Text(localizations.voiceGuidanceDescription),
              value: config.accessibility.enableVoiceGuidance,
              onChanged: viewModel.updateVoiceGuidance,
              secondary: const Icon(Icons.record_voice_over),
            ),
            
            // Haptic feedback toggle
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

  /// Builds the language settings section
  /// This demonstrates how localization preferences are managed
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
                Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.languageSettings,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Use device locale toggle
            SwitchListTile(
              title: Text(localizations.useDeviceLanguage),
              subtitle: Text(localizations.useDeviceLanguageDescription),
              value: config.localization.useDeviceLocale,
              onChanged: viewModel.updateUseDeviceLocale,
              secondary: const Icon(Icons.smartphone),
            ),
            
            // Language selection (only shown if not using device locale)
            if (!config.localization.useDeviceLocale) ...[
              const SizedBox(height: 16),
              Text(
                localizations.selectLanguage,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: config.localization.languageCode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: localizations.language,
                ),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'es', child: Text('Español')),
                  DropdownMenuItem(value: 'fr', child: Text('Français')),
                  DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                  DropdownMenuItem(value: 'ja', child: Text('日本語')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    viewModel.updateLanguageCode(value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds advanced settings section (controlled by feature flags)
  /// This demonstrates how white-labeling can control feature availability
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
                Icon(
                  Icons.settings_applications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.advancedSettings,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Export configuration button
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(localizations.exportSettings),
              subtitle: Text(localizations.exportSettingsDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.exportConfiguration,
            ),
            
            // Reset to defaults button
            ListTile(
              leading: Icon(Icons.restore, color: Theme.of(context).colorScheme.error),
              title: Text(
                localizations.resetToDefaults,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              subtitle: Text(localizations.resetToDefaultsDescription),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showResetConfirmation(context, localizations, viewModel),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds brand information section
  /// This shows the current white-label configuration to users
  Widget _buildBrandSection(
    BuildContext context,
    AppLocalizations localizations,
    AppConfig config,
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
                  Icons.business,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.aboutApp,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Brand information
            _buildInfoRow(localizations.appName, config.brand.appName),
            _buildInfoRow(localizations.version, '1.0.0'),
            _buildInfoRow(localizations.website, config.brand.websiteUrl),
            _buildInfoRow(localizations.support, config.brand.supportEmail),
          ],
        ),
      ),
    );
  }

  /// Helper method to build information rows
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
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  /// Shows confirmation dialog for resetting settings
  void _showResetConfirmation(
    BuildContext context,
    AppLocalizations localizations,
    SettingsViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.resetToDefaults),
        content: Text(localizations.resetConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.resetToDefaults();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(localizations.reset),
          ),
        ],
      ),
    );
  }
}