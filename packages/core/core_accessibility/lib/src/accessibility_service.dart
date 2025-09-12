import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Contract for app-wide accessibility services.
abstract class AccessibilityService {
  void announce(BuildContext context, String message, {TextDirection? textDirection});
  bool get reduceMotion;
  bool get highContrast;
}

/// No-op implementation useful for tests or when a real service is not needed.
class NoopAccessibilityService implements AccessibilityService {
  @override
  void announce(BuildContext context, String message, {TextDirection? textDirection}) {}

  @override
  bool get reduceMotion => false;

  @override
  bool get highContrast => false;
}

/// Default implementation backed by platform semantics and optional flags.
class DefaultAccessibilityService implements AccessibilityService {
  final bool _reduceMotion;
  final bool _highContrast;

  const DefaultAccessibilityService({bool reduceMotion = false, bool highContrast = false})
      : _reduceMotion = reduceMotion,
        _highContrast = highContrast;

  @override
  void announce(BuildContext context, String message, {TextDirection? textDirection}) {
    final direction = textDirection ?? Directionality.of(context);
    SemanticsService.announce(message, direction);
  }

  @override
  bool get reduceMotion => _reduceMotion;

  @override
  bool get highContrast => _highContrast;
}
