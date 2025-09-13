import 'package:feature_settings/src/presentation/views/settings_overlay.dart';
import 'package:flutter/material.dart';

/// A reusable button that opens the Settings overlay.
/// Small icon button that opens the settings overlay.
class SettingsButton extends StatelessWidget {
  /// Creates a SettingsButton.
  const SettingsButton({super.key, this.tooltip = 'Settings'});

  /// Tooltip for the button.
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      icon: const Icon(Icons.settings),
      onPressed: () {
        showSettingsOverlay(context);
      },
    );
  }
}
