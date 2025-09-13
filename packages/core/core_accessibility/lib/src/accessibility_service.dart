import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Contract for app-wide accessibility services.
abstract class AccessibilityService {
  /// Announces a message for accessibility, e.g. for screen readers.
  void announce(
    BuildContext context,
    String message, {
    TextDirection? textDirection,
  });

  /// Whether motion reduction is enabled.
  bool get reduceMotion;

  /// Whether high contrast mode is enabled.
  bool get highContrast;
}

/// No-op implementation useful for tests or when a real service is not needed.
class NoopAccessibilityService implements AccessibilityService {
  /// Announces a message for accessibility (no-op).
  @override
  void announce(
    BuildContext context,
    String message, {
    TextDirection? textDirection,
  }) {}

  /// Always returns false for reduced motion.
  @override
  bool get reduceMotion => false;

  /// Always returns false for high contrast.
  @override
  bool get highContrast => false;
}

/// Default implementation backed by platform semantics and optional flags.
class DefaultAccessibilityService implements AccessibilityService {
  /// Creates a [DefaultAccessibilityService].
  const DefaultAccessibilityService({
    bool reduceMotion = false,
    bool highContrast = false,
  }) : _reduceMotion = reduceMotion,
       _highContrast = highContrast;

  /// Whether motion reduction is enabled.
  final bool _reduceMotion;

  /// Whether high contrast mode is enabled.
  final bool _highContrast;

  /// Announces a message for accessibility using platform semantics.
  @override
  void announce(
    BuildContext context,
    String message, {
    TextDirection? textDirection,
  }) {
    final direction = textDirection ?? Directionality.of(context);
    SemanticsService.announce(message, direction);
  }

  /// Whether motion reduction is enabled.
  @override
  bool get reduceMotion => _reduceMotion;

  /// Whether high contrast mode is enabled.
  @override
  bool get highContrast => _highContrast;
}
