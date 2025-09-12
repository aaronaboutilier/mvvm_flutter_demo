# Enterprise Flutter Clean Architecture: Monorepo Edition

A comprehensive, production-ready Flutter monorepo template that implements Clean Architecture with MVVM pattern, designed specifically for enterprise-scale applications with internationalization, accessibility, theming, white labeling, and zero-logic views as core architectural principles. This architecture leverages the power of package-based organization with Melos workspace management to create truly scalable, maintainable enterprise applications.

## Architecture Philosophy: From Monolith to Modular Ecosystem

Traditional Flutter applications often start as single packages where all code lives together in one large structure. While this approach works for smaller applications, enterprise applications benefit tremendously from thinking about architecture as a collection of focused, interdependent packages rather than a monolithic codebase.

Consider the difference between a single large building where all rooms are connected and interdependent, versus a well-planned campus where each building serves a specific purpose while sharing common infrastructure like utilities and transportation. The monorepo approach transforms your Flutter application from the former into the latter, creating an ecosystem of packages that work together while maintaining clear boundaries and responsibilities.

This approach amplifies the benefits of Clean Architecture by making architectural boundaries explicit and enforceable through the package system itself. When your design system lives in its own package, other packages cannot accidentally violate its abstractions. When your feature packages cannot depend on each other directly, you naturally avoid the tight coupling that makes applications difficult to maintain and test.

### Core Design Principles

**Zero-Logic Views**: Views remain purely declarative across all packages, containing absolutely no conditional logic, calculations, or business decisions. All presentation logic resides in ViewModels through a slot-based widget system that treats UI as configurable templates. This principle becomes even more powerful in a monorepo because shared UI components can be developed once and reused across multiple features and applications.

**Package-Enforced SOLID Compliance**: Every component follows SOLID principles, but now these principles are enforced at the package level as well as the class level. Dependencies flow through well-defined package interfaces, single responsibility is maintained not just within classes but within entire packages, and the open-closed principle enables you to extend functionality by adding new packages rather than modifying existing ones.

**Architectural Boundary Enforcement**: The package structure creates unbreachable architectural boundaries. Feature packages cannot depend on other feature packages, ensuring that business domains remain properly separated. Core packages provide foundational capabilities that flow upward through the dependency graph, while feature packages consume these capabilities without being able to violate layer separation.

**Failure-Resilient Design**: All operations use the Either pattern for predictable error handling, with error types that can be shared across packages through core error handling packages. This creates consistency in how your entire application ecosystem handles and reports failures.

**Immutable State Management**: All data structures use Freezed for immutability, with state management patterns that work consistently across package boundaries. State changes flow unidirectionally through the architecture within each package and between packages through well-defined interfaces.

**Enterprise Security**: Sensitive data handling, input validation, and configuration management are centralized in core packages, ensuring that security practices are consistent across your entire application ecosystem while being maintainable from a single source of truth.

## Monorepo Structure: Understanding the Package Ecosystem

The monorepo structure organizes your application as a collection of focused packages, each serving a specific architectural or business purpose. This organization creates natural boundaries that prevent architectural violations while enabling code reuse and independent development of different application areas.

```
enterprise_flutter_monorepo/
├── melos.yaml                              # Workspace orchestration and command configuration
├── analysis_options.yaml                   # Shared code quality standards across all packages
├── packages/
│   ├── core/                              # Foundation packages that provide infrastructure
│   │   ├── core_design_system/            # Theme management, design tokens, base UI components
│   │   │   ├── lib/
│   │   │   │   ├── core_design_system.dart # Public API barrel file
│   │   │   │   └── src/
│   │   │   │       ├── tokens/            # Design tokens (colors, typography, spacing)
│   │   │   │       ├── themes/            # Theme implementations and services
│   │   │   │       ├── components/        # Reusable UI components (buttons, cards, forms)
│   │   │   │       └── services/          # Theme-related services and utilities
│   │   │   ├── test/                      # Comprehensive design system tests
│   │   │   └── example/                   # Design system showcase and examples
│   │   ├── core_networking/               # HTTP client configuration and API abstractions
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── clients/           # HTTP client implementations
│   │   │   │       ├── interceptors/      # Request/response interceptors
│   │   │   │       ├── models/            # Common API response models
│   │   │   │       └── services/          # Network-related services
│   │   │   └── test/
│   │   ├── core_storage/                  # Data persistence abstractions and implementations
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── secure_storage/    # Secure storage implementations
│   │   │   │       ├── cache/             # Caching strategies and implementations
│   │   │   │       └── database/          # Local database abstractions
│   │   │   └── test/
│   │   ├── core_localization/             # Internationalization and localization infrastructure
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── services/          # Translation services and locale management
│   │   │   │       ├── repositories/      # Translation data repositories
│   │   │   │       └── models/            # Localization-specific models
│   │   │   └── test/
│   │   ├── core_accessibility/            # Accessibility services and utilities
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── services/          # Screen reader integration, semantic builders
│   │   │   │       ├── widgets/           # Accessibility-enhanced widgets
│   │   │   │       └── utilities/         # Accessibility testing and validation utilities
│   │   │   └── test/
│   │   ├── core_analytics/                # Logging, performance monitoring, and analytics
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── logging/           # Structured logging implementations
│   │   │   │       ├── performance/       # Performance monitoring and tracking
│   │   │   │       └── analytics/         # User behavior analytics
│   │   │   └── test/
│   │   ├── core_error_handling/           # Centralized error handling and failure types
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── failures/          # Common failure types
│   │   │   │       ├── exceptions/        # Exception definitions
│   │   │   │       └── handlers/          # Error handling utilities
│   │   │   └── test/
│   │   └── core_testing/                  # Shared testing utilities and mocks
│   │       ├── lib/
│   │       │   └── src/
│   │       │       ├── mocks/             # Common mock implementations
│   │       │       ├── fixtures/          # Test data fixtures
│   │       │       └── utilities/         # Testing helper functions
│   │       └── test/
│   ├── shared/                            # Cross-cutting business domain packages
│   │   ├── shared_auth/                   # Authentication and authorization domain
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── data/              # Authentication data layer
│   │   │   │       ├── domain/            # Authentication business logic
│   │   │   │       └── presentation/      # Authentication UI components
│   │   │   └── test/
│   │   ├── shared_user/                   # User management domain
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── data/              # User data management
│   │   │   │       ├── domain/            # User business logic
│   │   │   │       └── presentation/      # User-related UI components
│   │   │   └── test/
│   │   ├── shared_navigation/             # Application-wide navigation
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── services/          # Navigation services and abstractions
│   │   │   │       ├── models/            # Navigation-related models
│   │   │   │       └── widgets/           # Navigation widgets and components
│   │   │   └── test/
│   │   └── shared_configuration/          # Configuration management and feature flags
│   │       ├── lib/
│   │       │   └── src/
│   │       │       ├── config/            # Environment and app configuration
│   │       │       ├── feature_flags/     # Feature flag management
│   │       │       └── services/          # Configuration services
│   │       └── test/
│   ├── features/                          # Business feature packages
│   │   ├── feature_dashboard/             # Dashboard and home screen functionality
│   │   │   ├── lib/
│   │   │   │   ├── feature_dashboard.dart # Public API for the dashboard feature
│   │   │   │   └── src/
│   │   │   │       ├── data/              # Dashboard data layer
│   │   │   │       │   ├── datasources/   # Remote and local data sources
│   │   │   │       │   ├── models/        # Data transfer objects
│   │   │   │       │   └── repositories/  # Repository implementations
│   │   │   │       ├── domain/            # Dashboard business logic layer
│   │   │   │       │   ├── entities/      # Dashboard business entities
│   │   │   │       │   ├── repositories/  # Repository contracts
│   │   │   │       │   └── usecases/      # Dashboard use cases
│   │   │   │       └── presentation/      # Dashboard UI layer with zero-logic views
│   │   │   │           ├── view_models/   # Dashboard presentation logic
│   │   │   │           ├── view_states/   # Dashboard UI state definitions
│   │   │   │           ├── pages/         # Complete dashboard pages
│   │   │   │           └── widgets/       # Dashboard-specific widgets
│   │   │   ├── test/                      # Feature-specific comprehensive tests
│   │   │   └── example/                   # Standalone dashboard feature demo
│   │   ├── feature_products/              # Product catalog and management
│   │   │   ├── lib/
│   │   │   │   ├── feature_products.dart  # Public API for product functionality
│   │   │   │   └── src/
│   │   │   │       ├── data/              # Product data layer
│   │   │   │       ├── domain/            # Product business logic
│   │   │   │       └── presentation/      # Product UI layer
│   │   │   ├── test/
│   │   │   └── example/
│   │   ├── feature_checkout/              # Checkout process and payment handling
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── data/              # Checkout and payment data layer
│   │   │   │       ├── domain/            # Checkout business logic
│   │   │   │       └── presentation/      # Checkout UI flow
│   │   │   ├── test/
│   │   │   └── example/
│   │   ├── feature_profile/               # User profile management
│   │   │   ├── lib/
│   │   │   │   └── src/
│   │   │   │       ├── data/              # Profile data management
│   │   │   │       ├── domain/            # Profile business logic
│   │   │   │       └── presentation/      # Profile UI components
│   │   │   ├── test/
│   │   │   └── example/
│   │   └── feature_notifications/         # Notification management and display
│   │       ├── lib/
│   │       │   └── src/
│   │       │       ├── data/              # Notification data layer
│   │       │       ├── domain/            # Notification business logic
│   │       │       └── presentation/      # Notification UI components
│   │       ├── test/
│   │       └── example/
│   └── apps/                              # Multiple application variants
│       ├── consumer_app/                  # Consumer-facing application
│       │   ├── lib/
│       │   │   ├── main.dart              # Consumer app entry point
│       │   │   ├── app/                   # App-level configuration and setup
│       │   │   ├── di/                    # Dependency injection configuration
│       │   │   └── config/                # Consumer app specific configuration
│       │   ├── test/
│       │   ├── integration_test/          # End-to-end tests for consumer app
│       │   ├── android/                   # Android-specific configuration
│       │   ├── ios/                       # iOS-specific configuration
│       │   └── web/                       # Web-specific configuration
│       ├── admin_app/                     # Administrative dashboard application
│       │   ├── lib/
│       │   │   ├── main.dart              # Admin app entry point
│       │   │   ├── app/                   # Admin app configuration
│       │   │   └── config/                # Admin-specific configuration
│       │   ├── test/
│       │   └── integration_test/          # Admin app end-to-end tests
│       └── white_label_app/               # Configurable white-label application
│           ├── lib/
│           │   ├── main.dart              # White-label app entry point
│           │   ├── app/                   # White-label app configuration
│           │   └── config/                # Brand-specific configuration management
│           ├── test/
│           └── integration_test/          # White-label app tests
├── tools/                                 # Development tools and automation scripts
│   ├── scripts/                          # Build and deployment scripts
│   ├── code_generation/                  # Code generation utilities
│   └── analysis/                         # Custom analysis and linting tools
├── docs/                                 # Comprehensive documentation
│   ├── architecture/                     # Architecture decision records
│   ├── features/                         # Feature-specific documentation
│   └── deployment/                       # Deployment and infrastructure guides
└── .github/                             # GitHub workflows and templates
    └── workflows/                        # CI/CD pipeline definitions
```

## Understanding Package Dependencies and Architectural Flow

The monorepo structure creates a natural dependency hierarchy that enforces clean architecture principles at the package level. Understanding this flow helps you see how architectural boundaries are maintained and why certain dependencies are allowed while others are prohibited.

At the foundation level, your core packages provide infrastructure capabilities that any other package can depend upon. These packages encapsulate cross-cutting concerns like networking, storage, theming, and localization. Core packages never depend on anything except external libraries and Flutter SDK components, making them stable and reusable.

Shared packages build upon core packages to provide common business domain functionality that multiple features might need. For example, authentication is used across many features, so it lives in a shared package. User management is another cross-cutting business concern that features need access to. Shared packages can depend on core packages and external libraries, but they cannot depend on feature packages.

Feature packages represent complete business capabilities and can depend on both core and shared packages, but they cannot depend on other feature packages. This restriction is crucial because it prevents feature coupling and ensures that business domains remain properly separated. If one feature needs functionality from another feature, that functionality should either be extracted into a shared package or communicated through well-defined application-level interfaces.

Application packages represent complete applications that bring together multiple features. They depend on the feature packages they need and configure how those features work together. Applications handle the orchestration and integration concerns that span multiple business domains.

This dependency flow ensures that changes in core packages are carefully considered because they affect everything above them, while changes in feature packages are isolated and cannot break other features. The structure naturally guides you toward making changes in the appropriate layer of the architecture.

## Melos Workspace Management: Orchestrating Your Development Ecosystem

Melos transforms your monorepo from a collection of loosely related packages into a unified development environment. Rather than managing each package individually, Melos provides workspace-level commands that understand the relationships between your packages and can operate on them intelligently.

Think of Melos as the conductor of an orchestra where each package is an instrument. Without a conductor, each musician plays their part independently, but the result might not be harmonious. With Melos conducting, all the packages work together in coordination, creating a symphony of functionality that serves your application's needs.

The workspace configuration file defines how Melos should orchestrate your development workflow:

```yaml
name: enterprise_flutter_app
description: Enterprise Flutter application with clean architecture and monorepo organization
repository: https://github.com/yourcompany/enterprise-flutter-app

# Define which directories contain packages that Melos should manage
packages:
  - packages/core/**
  - packages/shared/**
  - packages/features/**
  - apps/**

# Configure how Melos handles package operations
command:
  version:
    # Automatically link version changes to git commits for traceability
    linkToCommits: true
    # Generate workspace-level changelog that summarizes all package changes
    workspaceChangelog: true
    # Use conventional commits for automated version management
    conventionalCommits: true
    
  bootstrap:
    # Control dependency resolution to ensure reproducible builds
    runPubGetInParallel: false
    enforceLockfile: true
    # Automatically run code generation after package linking
    runPostBootstrapScript: true

# Define reusable scripts that operate across the entire workspace
scripts:
  # Code quality and analysis scripts
  analyze:all:
    description: Run static analysis across all packages with dependency-aware ordering
    run: flutter analyze
    exec:
      # Run analysis in parallel for faster feedback, but limit concurrency for resource management
      concurrency: 5
      # Fail fast if any package has analysis issues
      failFast: true
  
  format:all:
    description: Format code consistently across all packages
    run: dart format --set-exit-if-changed .
    exec:
      # High concurrency for formatting since it's less resource-intensive
      concurrency: 10
      
  # Testing scripts with different granularities
  test:all:
    description: Run comprehensive tests across all packages with coverage reporting
    run: flutter test --coverage --reporter=expanded
    exec:
      # Moderate concurrency for testing to balance speed with resource usage
      concurrency: 3
      # Order execution based on package dependencies
      orderDependents: true
      
  test:unit:
    description: Run only unit tests for rapid feedback during development
    run: flutter test test/unit --reporter=compact
    exec:
      concurrency: 5
      
  test:integration:
    description: Run integration tests that span package boundaries
    run: flutter test test/integration
    exec:
      # Lower concurrency for integration tests as they're more resource-intensive
      concurrency: 2
      orderDependents: true
      
  test:changed:
    description: Run tests only for packages that have changed since the last commit
    run: flutter test --coverage
    exec:
      # Use Melos's diff functionality to test only what's necessary
      since: HEAD~1
      concurrency: 3
      
  # Build and deployment scripts
  build:apps:
    description: Build all application variants
    run: flutter build apk --release
    # Apply this script only to packages that contain Android configuration
    packageFilters:
      dirExists: android
      
  build:web:
    description: Build web versions of applications
    run: flutter build web --release
    packageFilters:
      dirExists: web
      
  # Code generation scripts
  generate:all:
    description: Run code generation across all packages that need it
    run: flutter packages pub run build_runner build --delete-conflicting-outputs
    packageFilters:
      # Only run generation in packages that have build_runner configured
      dependsOn: "build_runner"
    exec:
      concurrency: 3
      
  generate:watch:
    description: Run code generation in watch mode for active development
    run: flutter packages pub run build_runner watch --delete-conflicting-outputs
    packageFilters:
      dependsOn: "build_runner"
      
  # Maintenance and cleanup scripts
  clean:all:
    description: Clean all packages to resolve build issues
    run: flutter clean
    exec:
      concurrency: 10
      
  upgrade:all:
    description: Upgrade dependencies across all packages
    run: flutter pub upgrade
    exec:
      concurrency: 5
      # Run upgrade in dependency order to handle version conflicts properly
      orderDependents: true
      
  # Package management scripts
  bootstrap:
    description: Initialize the workspace by linking packages and getting dependencies
    run: |
      melos clean &&
      flutter pub get &&
      melos generate:all
    exec:
      concurrency: 1
      orderDependents: true
```

This configuration transforms complex multi-package operations into simple commands. Instead of manually navigating to each package directory and running commands individually, you can orchestrate your entire development workflow from the workspace root.

## Core Package Architecture: Building Reusable Foundation Components

Core packages form the foundation of your application ecosystem, providing infrastructure and cross-cutting concerns that other packages depend upon. These packages must be designed with particular care because changes to them ripple throughout your entire application.

Let's examine how to structure a core design system package that demonstrates the principles of building reusable, focused packages that integrate seamlessly with clean architecture:

```yaml
# packages/core/core_design_system/pubspec.yaml
name: core_design_system
description: |
  Enterprise design system providing themes, design tokens, and base UI components.
  This package ensures visual consistency across all features and applications
  while providing the flexibility needed for white-label customization.
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  # Immutable data structures for theme configurations
  freezed_annotation: ^2.4.1
  # JSON serialization for theme loading from remote sources
  json_annotation: ^4.8.1
  # Functional programming utilities for theme operations
  dartz: ^0.10.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  # Code generation for freezed and JSON serialization
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  # Ensure code quality standards
  flutter_lints: ^3.0.0
  # Testing utilities that will be shared across packages
  mocktail: ^0.3.0
```

The internal structure of the design system package follows clean architecture principles while being optimized for reusability across the monorepo:

```dart
// packages/core/core_design_system/lib/core_design_system.dart
/// Public API barrel file that exposes only the interfaces and classes
/// that other packages should depend upon. This creates a clean contract
/// between the design system and its consumers.
library core_design_system;

// Export design tokens that other packages can reference
export 'src/tokens/color_tokens.dart';
export 'src/tokens/typography_tokens.dart';
export 'src/tokens/spacing_tokens.dart';
export 'src/tokens/radius_tokens.dart';

// Export theme services that other packages can inject and use
export 'src/services/theme_service.dart';
export 'src/services/design_token_service.dart';

// Export base components that features can extend or compose
export 'src/components/buttons/app_button.dart';
export 'src/components/cards/app_card.dart';
export 'src/components/forms/app_text_field.dart';

// Export theme configurations for application setup
export 'src/themes/app_theme.dart';
export 'src/themes/theme_data_builder.dart';

// Do not export internal implementation details from the src/internal directory
// This keeps the public API clean and allows for internal refactoring
```

The design token system provides the foundation for consistent visual design across all packages:

```dart
// packages/core/core_design_system/lib/src/tokens/color_tokens.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'color_tokens.freezed.dart';
part 'color_tokens.g.dart';

/// Design tokens for colors that provide semantic meaning rather than
/// just aesthetic values. These tokens enable theme switching, white-labeling,
/// and accessibility compliance through a centralized color system.
@freezed
class ColorTokens with _$ColorTokens {
  const factory ColorTokens({
    // Primary brand colors that define the application's visual identity
    required Color primary,
    required Color primaryVariant,
    required Color onPrimary,
    
    // Secondary colors that complement the primary brand
    required Color secondary,
    required Color secondaryVariant,
    required Color onSecondary,
    
    // Surface colors for backgrounds and container elements
    required Color surface,
    required Color surfaceVariant,
    required Color onSurface,
    
    // Semantic colors that convey meaning and state
    required Color success,
    required Color onSuccess,
    required Color warning,
    required Color onWarning,
    required Color error,
    required Color onError,
    
    // Interactive element colors
    required Color interactive,
    required Color interactiveHovered,
    required Color interactivePressed,
    required Color interactiveDisabled,
    
    // Text colors for different contexts and hierarchies
    required Color textPrimary,
    required Color textSecondary,
    required Color textTertiary,
    required Color textInverse,
  }) = _ColorTokens;
  
  factory ColorTokens.fromJson(Map<String, dynamic> json) => _$ColorTokensFromJson(json);
  
  /// Default light theme color tokens that provide a baseline
  /// for applications that don't need custom branding
  factory ColorTokens.light() {
    return const ColorTokens(
      primary: Color(0xFF1976D2),
      primaryVariant: Color(0xFF1565C0),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF03DAC6),
      secondaryVariant: Color(0xFF018786),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF3F3F3),
      onSurface: Color(0xFF1C1B1F),
      success: Color(0xFF4CAF50),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFFFF9800),
      onWarning: Color(0xFF000000),
      error: Color(0xFFB00020),
      onError: Color(0xFFFFFFFF),
      interactive: Color(0xFF1976D2),
      interactiveHovered: Color(0xFF1565C0),
      interactivePressed: Color(0xFF0D47A1),
      interactiveDisabled: Color(0xFFBDBDBD),
      textPrimary: Color(0xFF212121),
      textSecondary: Color(0xFF757575),
      textTertiary: Color(0xFF9E9E9E),
      textInverse: Color(0xFFFFFFFF),
    );
  }
  
  /// Dark theme color tokens that maintain the same semantic meaning
  /// while adapting to dark mode requirements
  factory ColorTokens.dark() {
    return const ColorTokens(
      primary: Color(0xFF90CAF9),
      primaryVariant: Color(0xFF64B5F6),
      onPrimary: Color(0xFF000000),
      secondary: Color(0xFF03DAC6),
      secondaryVariant: Color(0xFF018786),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFF121212),
      surfaceVariant: Color(0xFF2C2C2C),
      onSurface: Color(0xFFE1E1E1),
      success: Color(0xFF81C784),
      onSuccess: Color(0xFF000000),
      warning: Color(0xFFFFB74D),
      onWarning: Color(0xFF000000),
      error: Color(0xFFCF6679),
      onError: Color(0xFF000000),
      interactive: Color(0xFF90CAF9),
      interactiveHovered: Color(0xFF64B5F6),
      interactivePressed: Color(0xFF42A5F5),
      interactiveDisabled: Color(0xFF616161),
      textPrimary: Color(0xFFE1E1E1),
      textSecondary: Color(0xFFB0B0B0),
      textTertiary: Color(0xFF808080),
      textInverse: Color(0xFF212121),
    );
  }
}
```

The theme service provides runtime theme management that integrates with the zero-logic view architecture:

```dart
// packages/core/core_design_system/lib/src/services/theme_service.dart
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import '../tokens/color_tokens.dart';
import '../tokens/typography_tokens.dart';
import '../failures/theme_failures.dart';

/// Abstract theme service that provides theme management capabilities
/// while allowing different implementations for different use cases
/// (local themes, remote themes, white-label themes, etc.)
abstract class ThemeService {
  /// Get the current color tokens being used by the application
  ColorTokens getCurrentColorTokens();
  
  /// Get typography tokens for consistent text styling
  TypographyTokens getCurrentTypographyTokens();
  
  /// Switch between light and dark themes
  Future<Either<ThemeFailure, void>> switchTheme(ThemeMode mode);
  
  /// Load a custom theme configuration, useful for white-labeling
  Future<Either<ThemeFailure, void>> loadCustomTheme(String themeId);
  
  /// Stream of theme changes for reactive UI updates
  Stream<ColorTokens> get colorTokenChanges;
  
  /// Check if the current theme supports a specific feature
  bool supportsFeature(String featureName);
  
  /// Get theme-appropriate colors for specific UI contexts
  Color getButtonColor(ButtonType type, ButtonState state);
  Color getCardBackground(CardElevation elevation);
  Color getTextColor(TextContext context);
}

/// Implementation of theme service that manages themes locally
/// and provides the foundation for more complex theme management
class LocalThemeService implements ThemeService {
  final StreamController<ColorTokens> _colorTokenController = StreamController<ColorTokens>.broadcast();
  
  ColorTokens _currentColorTokens = ColorTokens.light();
  TypographyTokens _currentTypographyTokens = TypographyTokens.standard();
  ThemeMode _currentMode = ThemeMode.light;
  
  @override
  ColorTokens getCurrentColorTokens() => _currentColorTokens;
  
  @override
  TypographyTokens getCurrentTypographyTokens() => _currentTypographyTokens;
  
  @override
  Future<Either<ThemeFailure, void>> switchTheme(ThemeMode mode) async {
    try {
      _currentMode = mode;
      
      // Update color tokens based on the selected theme mode
      _currentColorTokens = mode == ThemeMode.dark 
          ? ColorTokens.dark() 
          : ColorTokens.light();
      
      // Notify listeners of the theme change
      _colorTokenController.add(_currentColorTokens);
      
      return const Right(null);
    } catch (e) {
      return Left(ThemeFailure('Failed to switch theme: ${e.toString()}'));
    }
  }
  
  @override
  Stream<ColorTokens> get colorTokenChanges => _colorTokenController.stream;
  
  @override
  Color getButtonColor(ButtonType type, ButtonState state) {
    // Centralized logic for determining button colors based on type and state
    // This keeps color logic out of individual button widgets
    switch (type) {
      case ButtonType.primary:
        switch (state) {
          case ButtonState.enabled:
            return _currentColorTokens.interactive;
          case ButtonState.hovered:
            return _currentColorTokens.interactiveHovered;
          case ButtonState.pressed:
            return _currentColorTokens.interactivePressed;
          case ButtonState.disabled:
            return _currentColorTokens.interactiveDisabled;
        }
      case ButtonType.secondary:
        switch (state) {
          case ButtonState.enabled:
            return _currentColorTokens.secondary;
          case ButtonState.hovered:
            return _currentColorTokens.secondaryVariant;
          case ButtonState.pressed:
            return _currentColorTokens.secondaryVariant.withOpacity(0.8);
          case ButtonState.disabled:
            return _currentColorTokens.interactiveDisabled;
        }
      case ButtonType.danger:
        switch (state) {
          case ButtonState.enabled:
            return _currentColorTokens.error;
          case ButtonState.hovered:
            return _currentColorTokens.error.withOpacity(0.8);
          case ButtonState.pressed:
            return _currentColorTokens.error.withOpacity(0.6);
          case ButtonState.disabled:
            return _currentColorTokens.interactiveDisabled;
        }
    }
  }
  
  void dispose() {
    _colorTokenController.close();
  }
}

// Enumerations that provide type safety for theme operations
enum ButtonType { primary, secondary, danger }
enum ButtonState { enabled, hovered, pressed, disabled }
enum CardElevation { low, medium, high }
enum TextContext { primary, secondary, tertiary, inverse }
```

## Feature Package Architecture: Implementing Business Domains

Feature packages represent complete business domains within your application, implementing the full clean architecture stack while being completely self-contained. Each feature package is essentially a mini-application that can be developed, tested, and deployed independently while integrating seamlessly with the broader application ecosystem.

Understanding how to structure feature packages properly is crucial because these packages contain your core business logic and represent the value your application provides to users. The structure must balance independence with integration, ensuring that features can evolve separately while working together harmoniously.

Let's examine a comprehensive example of how to structure a product catalog feature that demonstrates clean architecture principles within a package context:

```yaml
# packages/features/feature_products/pubspec.yaml
name: feature_products
description: |
  Product catalog and management feature providing comprehensive product
  browsing, searching, filtering, and detail viewing capabilities.
  This feature demonstrates how business domains can be completely
  self-contained while integrating with shared application infrastructure.
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.10.0"

dependencies:
  flutter:
    sdk: flutter
  
  # Core infrastructure dependencies that provide foundational capabilities
  core_design_system:
    path: ../../core/core_design_system
  core_networking:
    path: ../../core/core_networking
  core_storage:
    path: ../../core/core_storage
  core_localization:
    path: ../../core/core_localization
  core_accessibility:
    path: ../../core/core_accessibility
  core_analytics:
    path: ../../core/core_analytics
  core_error_handling:
    path: ../../core/core_error_handling
  
  # Shared business domain dependencies
  shared_auth:
    path: ../../shared/shared_auth
  shared_user:
    path: ../../shared/shared_user
  shared_configuration:
    path: ../../shared/shared_configuration
  
  # External dependencies for business logic implementation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  dartz: ^0.10.1
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  # Testing utilities from core package
  core_testing:
    path: ../../core/core_testing
  # Code generation dependencies
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  # Mocking for unit tests
  mocktail: ^0.3.0
```

The feature package public API defines what other packages can access from this feature:

```dart
// packages/features/feature_products/lib/feature_products.dart
/// Public API for the product catalog feature that exposes only the
/// interfaces and models that other parts of the application need.
/// This creates a clean contract between the product feature and the
/// rest of the application.
library feature_products;

// Export domain entities that other features might need to reference
export 'src/domain/entities/product.dart';
export 'src/domain/entities/product_category.dart';
export 'src/domain/entities/product_filter.dart';

// Export use case interfaces for dependency injection in applications
export 'src/domain/usecases/get_products_usecase.dart';
export 'src/domain/usecases/search_products_usecase.dart';
export 'src/domain/usecases/get_product_details_usecase.dart';

// Export repository interfaces for implementation swapping
export 'src/domain/repositories/product_repository.dart';

// Export presentation components that applications can integrate
export 'src/presentation/pages/product_list_page.dart';
export 'src/presentation/pages/product_detail_page.dart';
export 'src/presentation/widgets/product_card.dart';

// Export ViewModels for dependency injection configuration
export 'src/presentation/view_models/product_list_view_model.dart';
export 'src/presentation/view_models/product_detail_view_model.dart';

// Export data layer implementations for application configuration
export 'src/data/repositories/product_repository_impl.dart';

// Do not export internal implementation details, data sources, or view states
// These remain encapsulated within the feature package
```

The domain layer contains the core business logic and entities that define what a product is and how products behave within your business context:

```dart
// packages/features/feature_products/lib/src/domain/entities/product.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'product.freezed.dart';

/// Product entity that represents the core business concept of a product
/// within the application domain. This entity encapsulates all the properties
/// and business rules that define what a product is, independent of how
/// it's stored, displayed, or transmitted.
@freezed
class Product with _$Product {
  const factory Product({
    required ProductId id,
    required String name,
    required String description,
    required ProductPrice price,
    required ProductCategory category,
    required ProductAvailability availability,
    required List<ProductImage> images,
    required ProductRating rating,
    required ProductMetadata metadata,
    @Default([]) List<ProductTag> tags,
    @Default([]) List<ProductVariant> variants,
  }) = _Product;
  
  const Product._();
  
  /// Business rule: A product is purchasable if it's available and has a valid price
  bool get isPurchasable => availability.isAvailable && price.isValid;
  
  /// Business rule: A product is on sale if it has a discount price that's lower than the regular price
  bool get isOnSale => price.discountPrice != null && price.discountPrice! < price.regularPrice;
  
  /// Business rule: A product is new if it was created within the last 30 days
  bool get isNew => metadata.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)));
  
  /// Business rule: Calculate the effective price considering any active discounts
  double get effectivePrice => price.discountPrice ?? price.regularPrice;
  
  /// Business rule: Determine if the product is eligible for free shipping based on price thresholds
  bool isEligibleForFreeShipping(double freeShippingThreshold) {
    return effectivePrice >= freeShippingThreshold;
  }
  
  /// Business rule: Check if the product matches a given search query
  bool matchesSearchQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
           description.toLowerCase().contains(lowerQuery) ||
           tags.any((tag) => tag.name.toLowerCase().contains(lowerQuery));
  }
}

/// Value object representing a product identifier with validation
@freezed
class ProductId with _$ProductId {
  const factory ProductId(String value) = _ProductId;
  
  const ProductId._();
  
  /// Validation rule: Product IDs must be non-empty and follow a specific format
  bool get isValid => value.isNotEmpty && RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value);
}

/// Value object representing product pricing with business rules
@freezed
class ProductPrice with _$ProductPrice {
  const factory ProductPrice({
    required double regularPrice,
    double? discountPrice,
    required String currencyCode,
  }) = _ProductPrice;
  
  const ProductPrice._();
  
  /// Validation rule: Prices must be positive and discount prices must be less than regular prices
  bool get isValid {
    if (regularPrice <= 0) return false;
    if (discountPrice != null && (discountPrice! <= 0 || discountPrice! >= regularPrice)) return false;
    return true;
  }
  
  /// Calculate the discount percentage if a discount is applied
  double? get discountPercentage {
    if (discountPrice == null) return null;
    return ((regularPrice - discountPrice!) / regularPrice * 100);
  }
}
```

The use cases implement business operations that coordinate between different entities and external services:

```dart
// packages/features/feature_products/lib/src/domain/usecases/get_products_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:core_error_handling/core_error_handling.dart';
import '../entities/product.dart';
import '../entities/product_filter.dart';
import '../repositories/product_repository.dart';

/// Use case that handles the business logic for retrieving products
/// with filtering, sorting, and pagination. This use case coordinates
/// between the repository layer and the presentation layer while
/// implementing business rules for product retrieval.
class GetProductsUseCase {
  final ProductRepository _repository;
  final ProductCacheStrategy _cacheStrategy;
  final ProductFilterValidator _filterValidator;
  
  const GetProductsUseCase(
    this._repository,
    this._cacheStrategy,
    this._filterValidator,
  );
  
  /// Execute the use case to get products based on the provided request
  /// Returns either a failure or a paginated list of products
  Future<Either<Failure, ProductListResult>> execute(GetProductsRequest request) async {
    // Validate the request parameters to ensure they meet business requirements
    final validationResult = _validateRequest(request);
    if (validationResult != null) {
      return Left(validationResult);
    }
    
    // Check cache first if the cache strategy allows it
    if (_cacheStrategy.shouldUseCache(request)) {
      final cachedResult = await _repository.getCachedProducts(request);
      if (cachedResult.isRight()) {
        return cachedResult;
      }
    }
    
    // Fetch products from the repository
    final result = await _repository.getProducts(request);
    
    return result.fold(
      (failure) => Left(failure),
      (products) async {
        // Apply business rules to the retrieved products
        final filteredProducts = _applyBusinessRules(products, request);
        
        // Cache the result for future use
        await _cacheStrategy.cacheProducts(request, filteredProducts);
        
        // Return the final result
        return Right(ProductListResult(
          products: filteredProducts,
          totalCount: products.totalCount,
          hasMore: products.hasMore,
          nextPageToken: products.nextPageToken,
        ));
      },
    );
  }
  
  /// Validate the request to ensure it meets business requirements
  ValidationFailure? _validateRequest(GetProductsRequest request) {
    final errors = <String, List<String>>{};
    
    // Validate page size is within acceptable limits
    if (request.pageSize < 1 || request.pageSize > 100) {
      errors['pageSize'] = ['Page size must be between 1 and 100'];
    }
    
    // Validate filters using the injected validator
    final filterErrors = _filterValidator.validate(request.filters);
    if (filterErrors.isNotEmpty) {
      errors.addAll(filterErrors);
    }
    
    // Return validation failure if there are errors
    if (errors.isNotEmpty) {
      return ValidationFailure('Invalid request parameters', errors);
    }
    
    return null;
  }
  
  /// Apply business rules to filter and transform products
  List<Product> _applyBusinessRules(ProductListResult products, GetProductsRequest request) {
    var filteredProducts = products.products;
    
    // Apply availability filtering based on user context
    if (request.showOnlyAvailable) {
      filteredProducts = filteredProducts.where((product) => product.availability.isAvailable).toList();
    }
    
    // Apply price range filtering
    if (request.priceRange != null) {
      filteredProducts = filteredProducts.where((product) {
        final price = product.effectivePrice;
        return price >= request.priceRange!.min && price <= request.priceRange!.max;
      }).toList();
    }
    
    // Apply category filtering
    if (request.categoryIds.isNotEmpty) {
      filteredProducts = filteredProducts.where((product) {
        return request.categoryIds.contains(product.category.id);
      }).toList();
    }
    
    return filteredProducts;
  }
}

/// Request object that encapsulates all parameters for getting products
@freezed
class GetProductsRequest with _$GetProductsRequest {
  const factory GetProductsRequest({
    @Default(20) int pageSize,
    @Default(null) String? pageToken,
    @Default([]) List<ProductFilter> filters,
    @Default([]) List<String> categoryIds,
    @Default(null) PriceRange? priceRange,
    @Default(ProductSortOrder.relevance) ProductSortOrder sortOrder,
    @Default(false) bool showOnlyAvailable,
  }) = _GetProductsRequest;
}
```

The presentation layer implements zero-logic views and comprehensive ViewModels that handle all presentation concerns:

```dart
// packages/features/feature_products/lib/src/presentation/view_models/product_list_view_model.dart
import 'package:core_design_system/core_design_system.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_accessibility/core_accessibility.dart';
import 'package:core_analytics/core_analytics.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../view_states/product_list_view_state.dart';

/// ViewModel that handles all presentation logic for the product list screen.
/// This ViewModel coordinates between multiple use cases and services to
/// create the appropriate UI state while maintaining zero-logic views.
class ProductListViewModel extends BaseViewModel<ProductListViewState> {
  final GetProductsUseCase _getProductsUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final ThemeService _themeService;
  final LocalizationService _localizationService;
  final AccessibilityService _accessibilityService;
  final AnalyticsService _analyticsService;
  
  ProductListViewModel({
    required GetProductsUseCase getProductsUseCase,
    required SearchProductsUseCase searchProductsUseCase,
    required ThemeService themeService,
    required LocalizationService localizationService,
    required AccessibilityService accessibilityService,
    required AnalyticsService analyticsService,
  }) : _getProductsUseCase = getProductsUseCase,
       _searchProductsUseCase = searchProductsUseCase,
       _themeService = themeService,
       _localizationService = localizationService,
       _accessibilityService = accessibilityService,
       _analyticsService = analyticsService,
       super(ProductListViewState.initial());
  
  /// Load the initial list of products when the screen is first displayed
  Future<void> loadProducts() async {
    // Track the product loading event for analytics
    _analyticsService.track('product_list_load_started');
    
    // Update state to show loading
    updateState(state.copyWith(
      isLoading: true,
      hasError: false,
      errorMessage: '',
    ));
    
    final request = GetProductsRequest(
      pageSize: 20,
      sortOrder: ProductSortOrder.relevance,
      showOnlyAvailable: true,
    );
    
    final result = await _getProductsUseCase.execute(request);
    
    result.fold(
      (failure) => _handleLoadFailure(failure),
      (productResult) => _buildProductListState(productResult),
    );
  }
  
  /// Handle search functionality with debouncing and proper state management
  Future<void> searchProducts(String query) async {
    // Clear any existing search debounce timer
    _searchDebounceTimer?.cancel();
    
    // Update state to show that search is in progress
    updateState(state.copyWith(
      searchQuery: query,
      isSearching: true,
    ));
    
    // Debounce search requests to avoid excessive API calls
    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.trim().isEmpty) {
        // If query is empty, reload the default product list
        await loadProducts();
        return;
      }
      
      _analyticsService.track('product_search_performed', {
        'query': query,
        'query_length': query.length,
      });
      
      final searchRequest = SearchProductsRequest(
        query: query,
        pageSize: 20,
        includeAvailableOnly: true,
      );
      
      final result = await _searchProductsUseCase.execute(searchRequest);
      
      result.fold(
        (failure) => _handleSearchFailure(failure),
        (searchResult) => _buildSearchResultState(searchResult, query),
      );
    });
  }
  
  /// Build the UI state for displaying a list of products
  void _buildProductListState(ProductListResult productResult) {
    final productCards = productResult.products.map((product) => _buildProductCard(product)).toList();
    
    final headerText = _localizationService.translate(
      'products.list.header',
      args: {'count': productResult.totalCount},
    );
    
    final listSemanticLabel = _accessibilityService.buildSemanticLabel({
      'type': 'product_list',
      'count': productResult.products.length,
      'total': productResult.totalCount,
    });
    
    updateState(ProductListViewState(
      // Pre-built widgets for the zero-logic view
      headerSlot: Text(
        headerText,
        style: _themeService.getCurrentTypographyTokens().headlineMedium,
        semanticLabel: listSemanticLabel,
      ),
      
      // List of product card widgets ready for display
      productCardSlots: productCards,
      
      // Loading more button if there are more products available
      loadMoreSlot: productResult.hasMore 
          ? _buildLoadMoreButton(productResult.nextPageToken)
          : const SizedBox.shrink(),
      
      // Search bar widget configured for this context
      searchSlot: _buildSearchBar(),
      
      // Filter options widget
      filtersSlot: _buildFiltersWidget(),
      
      // State flags for conditional rendering
      showEmptyState: productResult.products.isEmpty,
      showLoadingIndicator: false,
      hasError: false,
      
      // Pre-calculated display values
      emptyStateMessage: _localizationService.translate('products.list.empty'),
      backgroundColor: _themeService.getCurrentColorTokens().surface,
    ));
    
    _analyticsService.track('product_list_loaded', {
      'product_count': productResult.products.length,
      'has_more': productResult.hasMore,
    });
  }
  
  /// Build individual product card widgets with all logic pre-calculated
  Widget _buildProductCard(Product product) {
    final cardColors = _themeService.getProductCardColors(product.category);
    final priceText = _formatProductPrice(product.price);
    final availabilityText = _buildAvailabilityText(product.availability);
    
    final cardSemanticLabel = _accessibilityService.buildSemanticLabel({
      'type': 'product_card',
      'name': product.name,
      'price': priceText,
      'availability': availabilityText,
      'rating': product.rating.averageRating,
    });
    
    return ProductCard(
      // All display logic handled here, not in the view
      titleSlot: Text(
        product.name,
        style: _themeService.getCurrentTypographyTokens().bodyLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      
      priceSlot: Text(
        priceText,
        style: _themeService.getCurrentTypographyTokens().bodyMedium.copyWith(
          color: product.isOnSale 
              ? _themeService.getCurrentColorTokens().error
              : _themeService.getCurrentColorTokens().textPrimary,
        ),
      ),
      
      imageSlot: _buildProductImage(product.images.isNotEmpty ? product.images.first : null),
      
      badgeSlot: _buildProductBadge(product),
      
      actionSlot: _buildProductAction(product),
      
      onTap: () => _handleProductTap(product),
      
      backgroundColor: cardColors.background,
      borderColor: cardColors.border,
      semanticLabel: cardSemanticLabel,
    );
  }
  
  /// Build product badge based on product state (new, on sale, etc.)
  Widget _buildProductBadge(Product product) {
    if (product.isNew && product.isOnSale) {
      // Show "New & On Sale" badge for products that are both new and discounted
      return MultiBadge(
        badges: [
          Badge(
            text: _localizationService.translate('products.badge.new'),
            color: _themeService.getCurrentColorTokens().success,
          ),
          Badge(
            text: _localizationService.translate('products.badge.sale'),
            color: _themeService.getCurrentColorTokens().warning,
          ),
        ],
      );
    } else if (product.isNew) {
      return Badge(
        text: _localizationService.translate('products.badge.new'),
        color: _themeService.getCurrentColorTokens().success,
      );
    } else if (product.isOnSale) {
      final discountText = _localizationService.translate(
        'products.badge.sale_percentage',
        args: {'percentage': product.price.discountPercentage?.round()},
      );
      return Badge(
        text: discountText,
        color: _themeService.getCurrentColorTokens().warning,
      );
    }
    
    return const SizedBox.shrink();
  }
  
  /// Build action button based on product availability and user context
  Widget _buildProductAction(Product product) {
    if (!product.availability.isAvailable) {
      return OutlinedButton(
        onPressed: () => _handleNotifyWhenAvailable(product),
        child: Text(_localizationService.translate('products.action.notify_when_available')),
      );
    }
    
    if (!product.isPurchasable) {
      return const SizedBox.shrink(); // No action for non-purchasable products
    }
    
    return ElevatedButton(
      onPressed: () => _handleAddToCart(product),
      style: ElevatedButton.styleFrom(
        backgroundColor: _themeService.getCurrentColorTokens().interactive,
        foregroundColor: _themeService.getCurrentColorTokens().onPrimary,
      ),
      child: Text(_localizationService.translate('products.action.add_to_cart')),
    );
  }
  
  void _handleProductTap(Product product) {
    _analyticsService.track('product_card_tapped', {
      'product_id': product.id.value,
      'product_name': product.name,
      'source': 'product_list',
    });
    
    // Navigation would be handled through a navigation service
    // keeping the ViewModel decoupled from navigation implementation
    navigationService.navigateToProductDetail(product.id);
  }
  
  Timer? _searchDebounceTimer;
  
  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    super.dispose();
  }
}
```

The zero-logic view simply displays the pre-calculated state from the ViewModel:

```dart
// packages/features/feature_products/lib/src/presentation/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:core_design_system/core_design_system.dart';
import '../view_models/product_list_view_model.dart';
import '../view_states/product_list_view_state.dart';

/// Zero-logic view that displays the product list using a slot-based layout.
/// This view contains no conditional logic, calculations, or business decisions.
/// All presentation logic is handled by the ProductListViewModel.
class ProductListPage extends StatelessWidget {
  final ProductListViewModel viewModel;
  
  const ProductListPage({
    super.key,
    required this.viewModel,
  });
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProductListViewState>(
      stream: viewModel.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? viewModel.state;
        
        return Scaffold(
          backgroundColor: state.backgroundColor,
          appBar: AppBar(
            title: state.headerSlot,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: state.searchSlot,
            ),
          ),
          body: Column(
            children: [
              // Filters section
              state.filtersSlot,
              
              // Main content area
              Expanded(
                child: _buildMainContent(state),
              ),
            ],
          ),
        );
      },
    );
  }
  
  /// Build the main content area based on the current state
  Widget _buildMainContent(ProductListViewState state) {
    if (state.showLoadingIndicator) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.errorIconSlot,
            const SizedBox(height: 16),
            state.errorMessageSlot,
            const SizedBox(height: 16),
            state.retryButtonSlot,
          ],
        ),
      );
    }
    
    if (state.showEmptyState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.emptyStateIconSlot,
            const SizedBox(height: 16),
            state.emptyStateMessageSlot,
          ],
        ),
      );
    }
    
    return ListView(
      children: [
        // Product grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: state.productCardSlots.length,
          itemBuilder: (context, index) {
            return state.productCardSlots[index];
          },
        ),
        
        // Load more section
        Padding(
          padding: const EdgeInsets.all(16),
          child: state.loadMoreSlot,
        ),
      ],
    );
  }
}
```

## Application Assembly: Bringing Packages Together

Application packages serve as the orchestration layer that brings together multiple feature packages and configures how they work together. Think of applications as conductors that coordinate different sections of an orchestra, ensuring that all the individual packages work together harmoniously to create a complete user experience.

The application layer is where you handle cross-feature concerns like navigation flows, global state management, and feature integration. This is also where you configure dependency injection, set up routing, and handle application lifecycle concerns.

```dart
// apps/consumer_app/lib/main.dart
import 'package:flutter/material.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_analytics/core_analytics.dart';
import 'package:shared_configuration/shared_configuration.dart';
import 'app/app.dart';
import 'app/dependency_injection.dart';

/// Application entry point that initializes the consumer app with all
/// necessary services and configuration. This function coordinates the
/// startup sequence to ensure all dependencies are properly configured
/// before the UI is displayed.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize application configuration based on the environment
  final appConfig = await AppConfigurationService.initialize(
    environment: Environment.fromString(const String.fromEnvironment('ENV', defaultValue: 'dev')),
  );
  
  // Configure dependency injection with all packages
  await configureDependencies(appConfig);
  
  // Initialize analytics and performance monitoring
  await getIt<AnalyticsService>().initialize();
  
  // Initialize localization with default locale
  await getIt<LocalizationService>().initialize();
  
  // Start the Flutter application
  runApp(ConsumerApp(config: appConfig));
}

/// Main application widget that configures the overall app structure
/// and integrates all the feature packages into a cohesive experience
class ConsumerApp extends StatelessWidget {
  final AppConfiguration config;
  
  const ConsumerApp({
    super.key,
    required this.config,
  });
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.appName,
      
      // Theme configuration from design system package
      theme: getIt<ThemeService>().getLightTheme(),
      darkTheme: getIt<ThemeService>().getDarkTheme(),
      themeMode: ThemeMode.system,
      
      // Localization configuration
      localizationsDelegates: getIt<LocalizationService>().getLocalizationDelegates(),
      supportedLocales: getIt<LocalizationService>().getSupportedLocales(),
      
      // Routing configuration that integrates all feature packages
      routerConfig: getIt<AppRouter>().config,
      
      // Global builder for accessibility and analytics
      builder: (context, child) {
        return AccessibilityWrapper(
          child: AnalyticsWrapper(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
```

The dependency injection configuration brings together all the packages and configures how they interact:

```dart
// apps/consumer_app/lib/app/dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:core_design_system/core_design_system.dart';
import 'package:core_networking/core_networking.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_accessibility/core_accessibility.dart';
import 'package:core_analytics/core_analytics.dart';
import 'package:shared_auth/shared_auth.dart';
import 'package:shared_user/shared_user.dart';
import 'package:shared_configuration/shared_configuration.dart';
import 'package:feature_products/feature_products.dart';
import 'package:feature_dashboard/feature_dashboard.dart';
import 'package:feature_checkout/feature_checkout.dart';
import 'package:feature_profile/feature_profile.dart';

final getIt = GetIt.instance;

/// Configure dependency injection for the entire application by registering
/// services from all packages and configuring their relationships.
/// This function demonstrates how the monorepo structure enables clean
/// dependency management across package boundaries.
Future<void> configureDependencies(AppConfiguration config) async {
  // Register core infrastructure services first
  await _registerCoreServices(config);
  
  // Register shared business services that depend on core services
  await _registerSharedServices();
  
  // Register feature-specific services and use cases
  await _registerFeatureServices();
  
  // Register application-level services that coordinate between features
  await _registerApplicationServices();
}

/// Register core infrastructure services that provide foundational capabilities
Future<void> _registerCoreServices(AppConfiguration config) async {
  // Network client configuration
  getIt.registerSingleton<ApiClient>(
    ApiClient(config: config.networkConfig),
  );
  
  // Storage services for data persistence
  getIt.registerSingleton<SecureStorageService>(
    FlutterSecureStorageService(),
  );
  
  getIt.registerSingleton<CacheService>(
    HiveCacheService(config: config.cacheConfig),
  );
  
  // Design system and theming services
  getIt.registerSingleton<ThemeService>(
    LocalThemeService(config: config.themeConfig),
  );
  
  // Localization services for internationalization
  getIt.registerSingleton<LocalizationService>(
    ArfLocalizationService(config: config.localizationConfig),
  );
  
  // Accessibility services for inclusive design
  getIt.registerSingleton<AccessibilityService>(
    PlatformAccessibilityService(),
  );
  
  // Analytics and monitoring services
  getIt.registerSingleton<AnalyticsService>(
    FirebaseAnalyticsService(config: config.analyticsConfig),
  );
  
  // Feature flag service for runtime configuration
  getIt.registerSingleton<FeatureFlagService>(
    RemoteFeatureFlagService(
      remoteConfig: getIt<ApiClient>(),
      cache: getIt<CacheService>(),
    ),
  );
}

/// Register shared business services that multiple features depend upon
Future<void> _registerSharedServices() async {
  // Authentication services
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: AuthRemoteDataSource(getIt<ApiClient>()),
      localDataSource: AuthLocalDataSource(getIt<SecureStorageService>()),
      cacheService: getIt<CacheService>(),
    ),
  );
  
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );
  
  // User management services
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSource(getIt<ApiClient>()),
      localDataSource: UserLocalDataSource(getIt<CacheService>()),
    ),
  );
  
  getIt.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<UserRepository>()),
  );
}

/// Register feature-specific services and use cases
Future<void> _registerFeatureServices() async {
  // Product feature services
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      remoteDataSource: ProductRemoteDataSource(getIt<ApiClient>()),
      localDataSource: ProductLocalDataSource(getIt<CacheService>()),
    ),
  );
  
  getIt.registerFactory<GetProductsUseCase>(
    () => GetProductsUseCase(
      getIt<ProductRepository>(),
      ProductCacheStrategy(getIt<CacheService>()),
      ProductFilterValidator(),
    ),
  );
  
  getIt.registerFactory<SearchProductsUseCase>(
    () => SearchProductsUseCase(getIt<ProductRepository>()),
  );
  
  getIt.registerFactory<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(getIt<ProductRepository>()),
  );
  
  // Product ViewModels
  getIt.registerFactory<ProductListViewModel>(
    () => ProductListViewModel(
      getProductsUseCase: getIt<GetProductsUseCase>(),
      searchProductsUseCase: getIt<SearchProductsUseCase>(),
      themeService: getIt<ThemeService>(),
      localizationService: getIt<LocalizationService>(),
      accessibilityService: getIt<AccessibilityService>(),
      analyticsService: getIt<AnalyticsService>(),
    ),
  );
  
  // Dashboard feature services
  getIt.registerFactory<DashboardViewModel>(
    () => DashboardViewModel(
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      featureFlagService: getIt<FeatureFlagService>(),
      themeService: getIt<ThemeService>(),
      localizationService: getIt<LocalizationService>(),
      analyticsService: getIt<AnalyticsService>(),
    ),
  );
  
  // Additional feature registrations would follow the same pattern
}

/// Register application-level services that coordinate between features
Future<void> _registerApplicationServices() async {
  // Navigation service that understands all feature routes
  getIt.registerSingleton<NavigationService>(
    GoRouterNavigationService(),
  );
  
  // App router that configures navigation between features
  getIt.registerSingleton<AppRouter>(
    AppRouter(
      authRepository: getIt<AuthRepository>(),
      featureFlagService: getIt<FeatureFlagService>(),
    ),
  );
  
  // Global state management for cross-feature concerns
  getIt.registerSingleton<AppStateManager>(
    AppStateManager(
      authRepository: getIt<AuthRepository>(),
      userRepository: getIt<UserRepository>(),
      analyticsService: getIt<AnalyticsService>(),
    ),
  );
}
```
