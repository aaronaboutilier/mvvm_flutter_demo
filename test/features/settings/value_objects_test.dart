import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/text_scale.dart';
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/language_code.dart';
import 'package:mvvm_flutter_demo/features/settings/domain/value_objects/theme_preference.dart';

void main() {
  group('TextScale', () {
    test('accepts values in range [0.5, 3.0]', () {
      expect(TextScale(0.5).value, 0.5);
      expect(TextScale(1.0).value, 1.0);
      expect(TextScale(3.0).value, 3.0);
    });

    test('throws for out-of-range values', () {
      expect(() => TextScale(0.49), throwsArgumentError);
      expect(() => TextScale(3.01), throwsArgumentError);
    });
  });

  group('LanguageCode', () {
    test('accepts non-empty short codes', () {
      expect(LanguageCode('en').value, 'en');
      expect(LanguageCode('es').value, 'es');
    });

    test('rejects empty or overly long codes', () {
      expect(() => LanguageCode(''), throwsArgumentError);
      expect(() => LanguageCode('toolonglang'), throwsArgumentError);
    });
  });

  group('ThemePreference', () {
    test('has expected values', () {
      expect(ThemePreference.values.length, 3);
      expect(ThemePreference.light.index, 0);
      expect(ThemePreference.dark.index, 1);
      expect(ThemePreference.system.index, 2);
    });
  });
}
