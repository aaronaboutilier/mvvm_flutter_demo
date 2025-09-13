import 'package:flutter/material.dart';

/// IconButton that logs an analytics event before invoking [onPressed].
class TrackedIconButton extends StatelessWidget {
  const TrackedIconButton({
    super.key,
    required this.icon,
    this.tooltip,
    this.onPressed,
    this.color,
    this.analyticsEventName,
    this.parameters,
    this.onAnalytics,
  });

  final Widget icon;
  final String? tooltip;
  final VoidCallback? onPressed;
  final Color? color;

  /// Optional analytics event name to log on press.
  final String? analyticsEventName;

  /// Optional dynamic parameters provider for analytics.
  final Map<String, Object?> Function()? parameters;

  /// Optional callback used to log analytics.
  /// If provided and [analyticsEventName] is set, this will be invoked
  /// before [onPressed].
  final Future<void> Function(String name, Map<String, Object?> params)?
  onAnalytics;

  @override
  Widget build(BuildContext context) {
    final handler = onPressed;
    VoidCallback? wrapped = handler;
    if (handler != null && analyticsEventName != null && onAnalytics != null) {
      wrapped = () {
        // Fire and forget; UI tap shouldn't await analytics.
        // ignore: discarded_futures
        onAnalytics!.call(
          analyticsEventName!,
          parameters?.call() ?? const <String, Object?>{},
        );
        handler();
      };
    }
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      color: color,
      onPressed: wrapped,
    );
  }
}

/// ElevatedButton that logs an analytics event before invoking [onPressed].
class TrackedElevatedButton extends StatelessWidget {
  const TrackedElevatedButton({
    super.key,
    required this.child,
    this.icon,
    this.onPressed,
    this.style,
    this.analyticsEventName,
    this.parameters,
    this.onAnalytics,
  });

  final Widget child;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  /// Optional analytics event name to log on press.
  final String? analyticsEventName;

  /// Optional dynamic parameters provider for analytics.
  final Map<String, Object?> Function()? parameters;

  /// Optional callback used to log analytics.
  /// If provided and [analyticsEventName] is set, this will be invoked
  /// before [onPressed].
  final Future<void> Function(String name, Map<String, Object?> params)?
  onAnalytics;

  @override
  Widget build(BuildContext context) {
    final handler = onPressed;
    VoidCallback? wrapped = handler;
    if (handler != null && analyticsEventName != null && onAnalytics != null) {
      wrapped = () {
        // ignore: discarded_futures
        onAnalytics!.call(
          analyticsEventName!,
          parameters?.call() ?? const <String, Object?>{},
        );
        handler();
      };
    }

    if (icon != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: wrapped,
        icon: icon!,
        label: child,
      );
    }

    return ElevatedButton(style: style, onPressed: wrapped, child: child);
  }
}
