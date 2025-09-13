/// Represents feature flags for configuration.
class FeatureFlags {
  /// Creates a [FeatureFlags] instance with the given [flags].
  const FeatureFlags(this.flags);

  /// The map of feature flag keys to enabled/disabled values.
  final Map<String, bool> flags;

  /// Returns true if the feature flag for [key] is enabled.
  bool isEnabled(String key) => flags[key] ?? false;
}
