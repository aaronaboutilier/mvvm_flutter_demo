# core_configuration

Core configuration models and service for the monorepo.

- AppConfig and nested models (BrandConfig, ThemeConfig, AccessibilityConfig, FeatureFlags, LocalizationConfig)
- ConfigService: loads base config (from assets), overlays user preferences, exposes updates and persistence

Depends on:
- core_foundation (for shared primitives later if needed)
- core_storage (for key-value abstraction in future; currently uses SharedPreferences directly)

