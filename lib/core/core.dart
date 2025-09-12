// Re-export core foundations from the dedicated package to ensure a single source of truth.
export 'package:core_foundation/core/errors/failure.dart';
export 'package:core_foundation/core/errors/failures.dart';
export 'package:core_foundation/core/result/result.dart';
export 'package:core_foundation/core/result/result_extensions.dart';
export 'package:core_foundation/core/usecase_base/usecase.dart';
export 'package:core_foundation/core/utils/error_mapper.dart';
export 'package:core_foundation/core/utils/logger.dart';
export 'package:core_foundation/core/utils/performance_monitor.dart';
// Local utilities that are still app-specific remain exported here.
export 'utils/guards.dart';
export 'utils/secure_storage.dart';
export 'utils/value_objects.dart';
export 'di/locator.dart';
// Prefer core_foundation for ViewModel abstractions across features
// Enterprise barrels
export 'configuration/configuration.dart';
export 'localization/localization.dart';
export 'theming/theming.dart';
export 'accessibility/accessibility.dart';
export 'analytics/analytics.dart';
