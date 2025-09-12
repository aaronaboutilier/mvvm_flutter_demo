import 'entities/feature_flags.dart';

abstract class ConfigRepository {
  Future<FeatureFlags> getFlags();
  Future<void> setFlag(String key, bool value);
}
