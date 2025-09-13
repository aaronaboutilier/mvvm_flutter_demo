import 'package:consumer_app/settings/consumer_settings_repository.dart';
import 'package:core_analytics/core_analytics.dart';
import 'package:core_foundation/core/core.dart';
import 'package:core_localization/generated/l10n/app_localizations.dart' as loc;
import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_details/feature_details.dart';
import 'package:feature_products/feature_products.dart';
import 'package:feature_settings/feature_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Entry point for the consumer app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Minimal DI wiring for feature packages
  final locator = GetIt.instance;
  // Core utilities required by feature packages
  if (!locator.isRegistered<Logger>()) {
    locator.registerLazySingleton<Logger>(() => const DebugLogger());
  }
  if (!locator.isRegistered<PerformanceMonitor>()) {
    locator.registerLazySingleton(() => PerformanceMonitor(locator()));
  }
  // App-provided repositories/bridges for features
  if (!locator.isRegistered<SettingsRepository>()) {
    locator.registerLazySingleton<SettingsRepository>(
      ConsumerSettingsRepository.new,
    );
  }
  registerFeatureDashboard(locator);
  registerFeatureProducts(locator);
  registerFeatureDetails(locator);
  registerFeatureSettings(locator);
  // Configure cross-cutting analytics
  //(replace with real implementation in prod)
  Analytics.backend = DebugAnalyticsService();
  runApp(const ConsumerApp());
}

/// Minimal app that composes feature routes.
class ConsumerApp extends StatefulWidget {
  /// Creates the ConsumerApp widget.
  const ConsumerApp({super.key});

  @override
  State<ConsumerApp> createState() => _ConsumerAppState();
}

class _ConsumerAppState extends State<ConsumerApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final settingsRepo =
        GetIt.I<SettingsRepository>() as ConsumerSettingsRepository;
    _router = GoRouter(
      initialLocation: DashboardRoutes.path,
      observers: <NavigatorObserver>[
        AnalyticsNavigatorObserver(Analytics.instance),
      ],
      routes: [
        ...featureDashboardRoutes(),
        ...featureProductsRoutes(),
        ...featureDetailsRoutes(),
      ],
      // Listen for settings changes without recreating the router
      refreshListenable: settingsRepo,
    );
  }

  /// Builds the root MaterialApp with GoRouter routes.
  @override
  Widget build(BuildContext context) {
    final settingsRepo =
        GetIt.I<SettingsRepository>() as ConsumerSettingsRepository;
    return ChangeNotifierProvider<ConsumerSettingsRepository>.value(
      value: settingsRepo,
      child: Builder(
        builder: (context) {
          final config = context
              .watch<ConsumerSettingsRepository>()
              .currentConfig;

          Color seedFromKey(String key) {
            switch (key) {
              case 'secondary':
                return const Color(0xFFFF9800);
              case 'success':
                return const Color(0xFF4CAF50);
              case 'danger':
                return const Color(0xFFF44336);
              case 'primary':
              default:
                return const Color(0xFF3F51B5);
            }
          }

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) =>
                loc.AppLocalizations.of(context).appTitle,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: seedFromKey(config.theme.accentColorKey),
              visualDensity: config.accessibility.largerTouchTargets
                  ? VisualDensity.comfortable
                  : VisualDensity.standard,
              materialTapTargetSize: config.accessibility.largerTouchTargets
                  ? MaterialTapTargetSize.padded
                  : MaterialTapTargetSize.shrinkWrap,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: seedFromKey(config.theme.accentColorKey),
              visualDensity: config.accessibility.largerTouchTargets
                  ? VisualDensity.comfortable
                  : VisualDensity.standard,
              materialTapTargetSize: config.accessibility.largerTouchTargets
                  ? MaterialTapTargetSize.padded
                  : MaterialTapTargetSize.shrinkWrap,
              brightness: Brightness.dark,
            ),
            themeMode: config.theme.themeMode,
            routerConfig: _router,
            localizationsDelegates: const [
              loc.AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: loc.AppLocalizations.supportedLocales,
            locale: config.localization.useDeviceLocale
                ? null
                : Locale(config.localization.languageCode),
            builder: (context, child) {
              // Apply text scale factor from settings.
              final media = MediaQuery.of(context);
              return MediaQuery(
                data: media.copyWith(
                  textScaler: TextScaler.linear(config.theme.textScaleFactor),
                  boldText:
                      config.accessibility.increasedContrast || media.boldText,
                ),
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
