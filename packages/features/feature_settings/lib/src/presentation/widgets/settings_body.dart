import 'package:core_design_system/core_design_system.dart';
import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:feature_settings/src/domain/entities/settings_config.dart';
import 'package:feature_settings/src/presentation/viewmodels/settings_view_state.dart';
import 'package:feature_settings/src/presentation/viewmodels/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Reusable Settings content that renders the settings sections.
///
/// Expects a [SettingsViewModel] to be available via Provider in the context.
class SettingsBody extends StatelessWidget {
  /// Creates a SettingsBody.
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SettingsViewModel>();
    return StreamBuilder<SettingsViewState>(
      stream: vm.stateStream,
      builder: (context, snapshot) {
        final _ = snapshot.data; // rebuild on state
        final config = vm.currentConfig;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildThemeSection(context, config, vm),
              const SizedBox(height: 24),
              _buildBrandColorsSection(context, config, vm),
              const SizedBox(height: 24),
              _buildAccessibilitySection(context, config, vm),
              const SizedBox(height: 24),
              _buildLanguageSection(context, config, vm),
              const SizedBox(height: 24),
              if (config.features.enableDataExport)
                _buildAdvancedSection(context, vm),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBrandColorsSection(
    BuildContext context,
    SettingsConfig config,
    SettingsViewModel viewModel,
  ) {
    // Temporary brand color choices using core_design_system tokens.
    final swatches = <_BrandColorChoice>[
      const _BrandColorChoice('primary', 'Primary', AppColors.primary),
      const _BrandColorChoice('secondary', 'Secondary', AppColors.secondary),
      const _BrandColorChoice('success', 'Success', AppColors.success),
      const _BrandColorChoice('danger', 'Danger', AppColors.danger),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.color_lens,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Brand colors',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Accent color', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final choice in swatches)
                  ChoiceChip(
                    label: Text(choice.label),
                    avatar: CircleAvatar(backgroundColor: choice.color),
                    selected: config.theme.accentColorKey == choice.key,
                    onSelected: (_) {
                      // Delegate to VM for future wiring (no-op for now)
                      viewModel.selectBrandAccentColor(choice.color);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'These colors come from core_design_system tokens '
              'and will be integrated with ThemeService.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    SettingsConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  AppLocalizations.of(context).theme,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context).themeMode),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(AppLocalizations.of(context).light),
                  icon: const Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(AppLocalizations.of(context).dark),
                  icon: const Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(AppLocalizations.of(context).system),
                  icon: const Icon(Icons.auto_mode),
                ),
              ],
              selected: {config.theme.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) =>
                  viewModel.updateThemeMode(selection.first),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context).textSize),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(AppLocalizations.of(context).small),
                Expanded(
                  child: Slider(
                    value: config.theme.textScaleFactor,
                    min: 0.8,
                    max: 2,
                    divisions: 12,
                    label: '${(config.theme.textScaleFactor * 100).round()}%',
                    onChanged: viewModel.updateTextScaleFactor,
                    semanticFormatterCallback: (value) =>
                        '${(value * 100).round()} percent text size',
                  ),
                ),
                Text(AppLocalizations.of(context).large),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilitySection(
    BuildContext context,
    SettingsConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  AppLocalizations.of(context).accessibility,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).reduceAnimations),
              value: config.accessibility.reduceAnimations,
              onChanged: (v) => viewModel.setReduceAnimations(enabled: v),
              secondary: const Icon(Icons.motion_photos_off),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).highContrast),
              value: config.accessibility.increasedContrast,
              onChanged: (v) => viewModel.setHighContrast(enabled: v),
              secondary: const Icon(Icons.contrast),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).largerTouchTargets),
              value: config.accessibility.largerTouchTargets,
              onChanged: (v) => viewModel.setLargerTouchTargets(enabled: v),
              secondary: const Icon(Icons.touch_app),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).voiceGuidance),
              value: config.accessibility.enableVoiceGuidance,
              onChanged: (v) => viewModel.setVoiceGuidanceEnabled(enabled: v),
              secondary: const Icon(Icons.record_voice_over),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).hapticFeedback),
              value: config.accessibility.enableHapticFeedback,
              onChanged: (v) => viewModel.setHapticFeedbackEnabled(enabled: v),
              secondary: const Icon(Icons.vibration),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    SettingsConfig config,
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  AppLocalizations.of(context).language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context).useDeviceLanguage),
              value: config.localization.useDeviceLocale,
              onChanged: (v) =>
                  viewModel.setUseDeviceLocale(useDeviceLocale: v),
              secondary: const Icon(Icons.smartphone),
            ),
            if (!config.localization.useDeviceLocale) ...[
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context).selectLanguage),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue:
                    const [
                      'en',
                      'es',
                    ].contains(config.localization.languageCode)
                    ? config.localization.languageCode
                    : 'en',
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).language,
                ),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'es', child: Text('Español')),
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
    SettingsViewModel viewModel,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  AppLocalizations.of(context).advanced,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(AppLocalizations.of(context).exportConfiguration),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.exportConfiguration,
            ),
            ListTile(
              leading: Icon(
                Icons.restore,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                AppLocalizations.of(context).resetToDefaults,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.resetToDefaults,
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandColorChoice {
  const _BrandColorChoice(this.key, this.label, this.color);
  final String key;
  final String label;
  final Color color;
}
