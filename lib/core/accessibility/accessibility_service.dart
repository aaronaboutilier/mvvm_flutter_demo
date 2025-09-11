import 'package:flutter/material.dart';

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
