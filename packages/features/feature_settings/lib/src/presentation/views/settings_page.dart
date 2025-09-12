import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:feature_dashboard/feature_dashboard.dart' show DashboardRoutes;
import '../viewmodels/settings_viewmodel.dart';
import '../viewmodels/settings_view_state.dart';
import '../../domain/entities/settings_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SettingsViewModel>(
      create: (context) => GetIt.I<SettingsViewModel>(),
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
    final vm = context.read<SettingsViewModel>();
    return StreamBuilder<SettingsViewState>(
      stream: vm.stateStream,
      builder: (context, snapshot) {
        final _ = snapshot.data; // rebuild on state
  final config = vm.currentConfig;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(DashboardRoutes.path),
              tooltip: 'Back to Home',
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThemeSection(context, config, vm),
                const SizedBox(height: 24),
                _buildAccessibilitySection(context, config, vm),
                const SizedBox(height: 24),
                _buildLanguageSection(context, config, vm),
                const SizedBox(height: 24),
                if (config.features.enableDataExport)
                  _buildAdvancedSection(context, vm),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeSection(BuildContext context, SettingsConfig config, SettingsViewModel viewModel) {
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
                  'Theme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Theme mode'),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.light, label: Text('Light'), icon: Icon(Icons.light_mode)),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark'), icon: Icon(Icons.dark_mode)),
                ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.auto_mode)),
              ],
              selected: {config.theme.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) => viewModel.updateThemeMode(selection.first),
            ),
            const SizedBox(height: 16),
            const Text('Text size'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Small'),
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
                const Text('Large'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilitySection(BuildContext context, SettingsConfig config, SettingsViewModel viewModel) {
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
                Text('Accessibility', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Reduce animations'),
              value: config.accessibility.reduceAnimations,
              onChanged: viewModel.updateReduceAnimations,
              secondary: const Icon(Icons.motion_photos_off),
            ),
            SwitchListTile(
              title: const Text('High contrast'),
              value: config.accessibility.increasedContrast,
              onChanged: viewModel.updateHighContrast,
              secondary: const Icon(Icons.contrast),
            ),
            SwitchListTile(
              title: const Text('Larger touch targets'),
              value: config.accessibility.largerTouchTargets,
              onChanged: viewModel.updateLargerTouchTargets,
              secondary: const Icon(Icons.touch_app),
            ),
            SwitchListTile(
              title: const Text('Voice guidance'),
              value: config.accessibility.enableVoiceGuidance,
              onChanged: viewModel.updateVoiceGuidance,
              secondary: const Icon(Icons.record_voice_over),
            ),
            SwitchListTile(
              title: const Text('Haptic feedback'),
              value: config.accessibility.enableHapticFeedback,
              onChanged: viewModel.updateHapticFeedback,
              secondary: const Icon(Icons.vibration),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, SettingsConfig config, SettingsViewModel viewModel) {
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
                Text('Language', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Use device language'),
              value: config.localization.useDeviceLocale,
              onChanged: viewModel.updateUseDeviceLocale,
              secondary: const Icon(Icons.smartphone),
            ),
            if (!config.localization.useDeviceLocale) ...[
              const SizedBox(height: 16),
              const Text('Select language'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: config.localization.languageCode,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Language'),
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

  Widget _buildAdvancedSection(BuildContext context, SettingsViewModel viewModel) {
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
                Text('Advanced', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export configuration'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.exportConfiguration,
            ),
            ListTile(
              leading: Icon(Icons.restore, color: Theme.of(context).colorScheme.error),
              title: Text('Reset to defaults', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: viewModel.resetToDefaults,
            ),
          ],
        ),
      ),
    );
  }
}
