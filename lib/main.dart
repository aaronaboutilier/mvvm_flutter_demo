// lib/main.dart

import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm_flutter_demo/core/localization/localization.dart';
import 'package:mvvm_flutter_demo/core/configuration/configuration.dart';
import 'package:mvvm_flutter_demo/core/di/locator.dart';
import 'package:mvvm_flutter_demo/features/home/presentation/views/home_view.dart';
import 'package:mvvm_flutter_demo/features/details/presentation/views/details_view.dart';
import 'package:mvvm_flutter_demo/features/settings/presentation/views/settings_view.dart';
import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_products/feature_products.dart';

/// The main entry point of our enhanced MVVM Flutter application
/// This demonstrates how i18n, a11y, theming, and white-labeling 
/// integrate seamlessly with your existing MVVM architecture
void main() async {
  // Ensure Flutter binding is initialized before doing async work
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the configuration service early in the app lifecycle
  // This loads brand configuration, user preferences, and accessibility settings
  setupLocator();
  await locator<ConfigService>().initialize(
    // You can specify a brand-specific config file for white-labeling
    // brandConfigPath: 'assets/config/brand_a_config.json',
  );
  
  // Set preferred orientations (can be driven by configuration)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MVVMDemoApp());
}

/// The root widget that brings together all our enhanced features
/// Notice how this builds on your existing MVVM structure while adding
/// powerful configuration-driven capabilities
class MVVMDemoApp extends StatelessWidget {
  const MVVMDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the entire app with ChangeNotifierProvider for ConfigService
    // This makes configuration available throughout your widget tree
    // and ensures the app rebuilds when configuration changes
    return ChangeNotifierProvider<ConfigService>.value(
      value: locator<ConfigService>(),
      child: Consumer<ConfigService>(
        builder: (context, configService, child) {
          // Show a loading screen while configuration initializes
          if (!configService.isInitialized) {
            return const MaterialApp(
              home: _LoadingScreen(),
              debugShowCheckedModeBanner: false,
            );
          }

          final config = configService.currentConfig;
          
          return MaterialApp.router(
            // App title from brand configuration
            title: config.brand.appName,
            
            // Theme configuration that responds to user preferences and brand settings
            theme: _buildTheme(config, Brightness.light),
            darkTheme: _buildTheme(config, Brightness.dark),
            themeMode: config.theme.themeMode,
            
            // Internationalization and localization setup
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            
            // Supported locales from your ARB files
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'ES'),
              Locale('fr', 'FR'),
              Locale('de', 'DE'),
              Locale('ja', 'JP'),
            ],
            
            // Use configured locale or device default
            locale: config.localization.useDeviceLocale 
                ? null 
                : config.localization.locale,
            
            // Router configuration
            routerConfig: _buildRouter(config),
            
            // Remove debug banner for cleaner appearance
            debugShowCheckedModeBanner: false,
            
            // Accessibility and platform configuration
            builder: (context, child) {
              return _AccessibilityWrapper(
                config: config,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }

  /// Builds a theme based on configuration and brightness
  /// This method demonstrates how brand colors, accessibility preferences,
  /// and user settings all combine to create the final visual experience
  ThemeData _buildTheme(AppConfig config, Brightness brightness) {
    final brand = config.brand;
    final theme = config.theme;
    final accessibility = config.accessibility;
    
    // Create color scheme from brand configuration
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: brand.primaryColor,
      brightness: brightness,
      // Apply high contrast if needed for accessibility
      contrastLevel: accessibility.increasedContrast ? 1.0 : 0.0,
    );
    
    // Override specific colors with brand configuration
    colorScheme = colorScheme.copyWith(
      primary: brand.primaryColor,
      secondary: brand.secondaryColor,
      tertiary: brand.accentColor,
    );

    return ThemeData(
      useMaterial3: theme.useMaterial3,
      colorScheme: colorScheme,
      visualDensity: theme.visualDensity,
      
      // Font configuration from brand settings
      fontFamily: brand.fontFamily,
      
      // Accessibility-aware text theme
      textTheme: _buildTextTheme(theme.textScaleFactor),
      
      // Accessibility-aware component themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            accessibility.largerTouchTargets ? 64 : 44,
            accessibility.minimumTouchSize,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: accessibility.largerTouchTargets ? 24 : 16,
            vertical: accessibility.largerTouchTargets ? 16 : 12,
          ),
        ),
      ),
      
      // Card theme with accessibility considerations
      cardTheme: CardThemeData(
        elevation: accessibility.increasedContrast ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: accessibility.increasedContrast 
              ? BorderSide(color: colorScheme.outline, width: 1)
              : BorderSide.none,
        ),
      ),
      
      // Animation duration based on accessibility preferences
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: accessibility.reduceAnimations
              ? const FadeUpwardsPageTransitionsBuilder()
              : const ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: accessibility.reduceAnimations
              ? const CupertinoPageTransitionsBuilder()
              : const CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Builds text theme with accessibility text scaling
  TextTheme _buildTextTheme(double textScaleFactor) {
    return ThemeData.light().textTheme.apply(
      fontSizeFactor: textScaleFactor,
      // Ensure text remains readable even with large scale factors
      fontSizeDelta: textScaleFactor > 1.5 ? 2.0 : 0.0,
    );
  }

  /// Builds router configuration with feature flag integration
  GoRouter _buildRouter(AppConfig config) {
    final featureRoutes = <RouteBase>[
      ...featureDashboardRoutes(),
      ...featureProductsRoutes(),
    ];

    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/details',
          name: 'details',
          builder: (context, state) => const DetailsView(),
        ),
        // Conditionally include settings route based on feature flags
        if (config.features.enableUserProfiles)
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsView(),
          ),
        // Feature routes
        ...featureRoutes,
      ],

      // Accessibility-aware error page
      errorBuilder: (context, state) => _ErrorPage(
        error: state.error.toString(),
        config: config,
      ),
    );
  }
}

/// Loading screen shown while configuration initializes
/// This provides immediate visual feedback to users
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              semanticsLabel: 'Loading application...',
            ),
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Wrapper that applies accessibility configurations
/// This demonstrates how accessibility concerns are handled at the app level
/// Enhanced with accessibility_tools for comprehensive testing capabilities
class _AccessibilityWrapper extends StatelessWidget {
  final AppConfig config;
  final Widget child;

  const _AccessibilityWrapper({
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    
    // Apply reduced motion if configured
    if (config.accessibility.reduceAnimations) {
      result = _ReducedMotionWrapper(child: result);
    }
    
    // Apply text scaling
    if (config.theme.textScaleFactor != 1.0) {
      result = MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(config.theme.textScaleFactor),
        ),
        child: result,
      );
    }
    
    // Add semantic labels if enabled
    if (config.accessibility.enableSemanticLabels) {
      result = Semantics(
        container: true,
        child: result,
      );
    }
    
    // Wrap with AccessibilityTools for development testing
    // This provides a powerful overlay for testing accessibility features
    // The tools only appear in debug mode and don't affect production builds
    result = AccessibilityTools(
      // Configure which accessibility checkers to enable
      // These help validate your accessibility implementation
      checkFontOverflows: true,  // Ensures text doesn't overflow at large font sizes
      
      // Enable specific accessibility guidelines
      // These automatically test your app against accessibility standards
      // enabledGuidelines: [
      //   // Ensures all interactive elements meet minimum touch target sizes
      //   AccessibilityGuideline.minimumTapTargetSize,
      //   // Validates that tappable elements have semantic labels
      //   AccessibilityGuideline.labeledTapTargets,
      //   // Checks color contrast ratios for text readability
      //   AccessibilityGuideline.textContrast,
      // ],
      child: result,
    );
    
    return result;
  }
}

/// Widget that reduces animations for motion-sensitive users
class _ReducedMotionWrapper extends StatelessWidget {
  final Widget child;

  const _ReducedMotionWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100), // Very fast transitions
      child: child,
    );
  }
}

/// Accessibility-aware error page
class _ErrorPage extends StatelessWidget {
  final String error;
  final AppConfig config;

  const _ErrorPage({
    required this.error,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.pageNotFound),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: config.accessibility.largerTouchTargets ? 80 : 64,
              color: Theme.of(context).colorScheme.error,
              semanticLabel: 'Error icon',
            ),
            const SizedBox(height: 16),
            Text(
              localizations.pageNotFoundMessage,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text(localizations.goHome),
            ),
            if (config.features.enableDataExport) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Export error information for debugging
                  debugPrint('Error details: $error');
                },
                child: const Text('Report Error'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}