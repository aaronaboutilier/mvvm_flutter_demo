class FeatureFlags {
  final Map<String, bool> flags;

  const FeatureFlags(this.flags);

  bool isEnabled(String key) => flags[key] ?? false;
}
