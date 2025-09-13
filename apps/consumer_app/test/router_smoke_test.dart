import 'package:core_foundation/core/core.dart';
import 'package:core_localization/generated/l10n/app_localizations.dart'
    as l10n;
import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_products/feature_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('router builds and initial route is dashboard', (tester) async {
    // Increase viewport to avoid overflow from demo UI in tests
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    // Setup minimal DI required by Dashboard feature
    final locator = GetIt.I;
    await locator.reset();
    locator
      ..registerLazySingleton<Logger>(() => const DebugLogger())
      ..registerLazySingleton(() => PerformanceMonitor(locator()));
    registerFeatureDashboard(locator);

    final router = GoRouter(
      initialLocation: DashboardRoutes.path,
      routes: [...featureDashboardRoutes(), ...featureProductsRoutes()],
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: const [
          l10n.AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: l10n.AppLocalizations.supportedLocales,
        locale: const Locale('en'),
      ),
    );
    // Allow async user load (simulated 800ms) to complete
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Verify that DashboardPage title is present
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
