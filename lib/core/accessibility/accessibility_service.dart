import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../configuration/configuration.dart';

abstract class AccessibilityService {
  void announce(BuildContext context, String message, {TextDirection? textDirection});
  bool get reduceMotion;
  bool get highContrast;
}

class NoopAccessibilityService implements AccessibilityService {
  @override
  void announce(BuildContext context, String message, {TextDirection? textDirection}) {
    // Integrate with SemanticsService.announce or platform channels later.
  }

  @override
  bool get reduceMotion => false;

  @override
  bool get highContrast => false;
}

/// Default implementation using Flutter's SemanticsService and app configuration.
class DefaultAccessibilityService implements AccessibilityService {
  final ConfigService _configService;

  const DefaultAccessibilityService(this._configService);

  @override
  void announce(BuildContext context, String message, {TextDirection? textDirection}) {
    final direction = textDirection ?? Directionality.of(context);
    // Announce message for screen readers.
    SemanticsService.announce(message, direction);
  }

  @override
  bool get reduceMotion => _configService.currentConfig.accessibility.reduceAnimations;

  @override
  bool get highContrast => _configService.currentConfig.accessibility.increasedContrast;
}
