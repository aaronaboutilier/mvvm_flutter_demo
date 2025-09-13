import 'package:shared_configuration/src/domain/entities/feature_flags.dart';

/// Repository interface for managing feature flags configuration.
abstract class ConfigRepository {
  /// Gets the current feature flags.
  Future<FeatureFlags> getFlags();

  /// Sets the value for a feature flag with [key].
  Future<void> setFlag(String key, {required bool value});
}
