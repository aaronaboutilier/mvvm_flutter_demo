# GitHub Copilot Instructions: Enterprise Flutter Clean Architecture Monorepo

## Core Principles

### 1. Zero-Logic Views
- Views contain **NO** conditional logic, calculations, or business decisions
- All presentation logic goes in ViewModels using slot-based architecture
- Views only display pre-built widgets from ViewModel state
- Use `StreamBuilder<ViewState>` pattern for reactive updates

```dart
// ✅ Correct: Zero-logic view
Widget build(BuildContext context) {
  return StreamBuilder<ProductListViewState>(
    stream: viewModel.stateStream,
    builder: (context, snapshot) {
      final state = snapshot.data ?? viewModel.state;
      return Column(children: [
        state.headerSlot,        // Pre-built widget
        state.searchSlot,        // Pre-built widget
        ...state.productSlots,   // Pre-built list
      ]);
    },
  );
}

// ❌ Wrong: Logic in view
Widget build(BuildContext context) {
  return Column(
    children: products.map((product) => 
      product.isAvailable ? ProductCard(...) : Container()
    ).toList(),
  );
}
```

### 2. Package Structure & Dependencies
```
packages/
├── core/           # Infrastructure (networking, storage, design_system)
├── shared/         # Cross-cutting business (auth, user, navigation)  
├── features/       # Business domains (products, checkout, profile)
└── apps/           # Applications (consumer_app, admin_app)
```

**Dependency Rules:**
- Core packages: Only depend on Flutter SDK + external packages
- Shared packages: Can depend on core packages
- Feature packages: Can depend on core + shared (NOT other features)
- App packages: Can depend on any package

### 3. Feature Package Structure
```
feature_*/
├── lib/
│   ├── feature_*.dart      # Public API barrel file
│   └── src/
│       ├── data/           # Repositories, datasources, DTOs
│       ├── domain/         # Entities, use cases, repository interfaces
│       └── presentation/   # ViewModels, view states, pages, widgets
```

### 4. Freezed for All Data Classes
```dart
@freezed
class Product with _$Product {
  const factory Product({
    required ProductId id,
    required String name,
    required ProductPrice price,
  }) = _Product;
  
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
```

### 5. Either Pattern for Error Handling
```dart
Future<Either<Failure, List<Product>>> getProducts() async {
  try {
    final products = await dataSource.getProducts();
    return Right(products);
  } catch (e) {
    return Left(NetworkFailure(e.toString()));
  }
}
```

### 6. ViewModel Pattern
```dart
class ProductListViewModel extends BaseViewModel<ProductListViewState> {
  Future<void> loadProducts() async {
    updateState(state.copyWith(isLoading: true));
    
    final result = await useCase.execute(request);
    
    result.fold(
      (failure) => _handleError(failure),
      (products) => _buildSuccessState(products),
    );
  }
  
  void _buildSuccessState(List<Product> products) {
    final productCards = products.map(_buildProductCard).toList();
    
    updateState(ProductListViewState(
      productSlots: productCards,     // Pre-built widgets
      headerSlot: _buildHeader(),     // Pre-built widget
      isLoading: false,
    ));
  }
}
```

## Coding Standards

### File Naming
- `snake_case` for files and directories
- Feature packages: `feature_[domain]` (e.g., `feature_products`)
- Core packages: `core_[capability]` (e.g., `core_networking`)
- Shared packages: `shared_[domain]` (e.g., `shared_auth`)

### Import Organization
```dart
// 1. Flutter/Dart imports
import 'package:flutter/material.dart';

// 2. External package imports  
import 'package:freezed_annotation/freezed_annotation.dart';

// 3. Internal package imports (core first, then shared)
import 'package:core_design_system/core_design_system.dart';
import 'package:shared_auth/shared_auth.dart';

// 4. Relative imports
import '../entities/product.dart';
```

### Repository Pattern
```dart
// Domain layer - interface
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(GetProductsRequest request);
}

// Data layer - implementation
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  
  @override
  Future<Either<Failure, List<Product>>> getProducts(GetProductsRequest request) async {
    // Implementation with caching, error handling, etc.
  }
}
```

### Use Case Pattern
```dart
class GetProductsUseCase {
  final ProductRepository repository;
  
  Future<Either<Failure, ProductListResult>> execute(GetProductsRequest request) async {
    // Validate request
    final validation = _validateRequest(request);
    if (validation != null) return Left(validation);
    
    // Execute business logic
    return repository.getProducts(request);
  }
}
```

## Key Patterns

### 1. Slot-Based UI
ViewModels prepare complete widgets that views simply display:
```dart
// ViewModel builds complete UI elements
Widget _buildProductCard(Product product) {
  return ProductCard(
    titleSlot: Text(product.name),
    priceSlot: Text(_formatPrice(product.price)),
    imageSlot: CachedNetworkImage(imageUrl: product.imageUrl),
    onTap: () => _handleTap(product),
  );
}

// View just displays slots
Widget build(context) => ListView(children: state.productCardSlots);
```

### 2. Barrel Exports
Each package exposes clean public API:
```dart
// lib/feature_products.dart
library feature_products;

// Export only what other packages should use
export 'src/domain/entities/product.dart';
export 'src/presentation/pages/product_list_page.dart';
export 'src/presentation/view_models/product_list_view_model.dart';

// Don't export internal implementation details
```

### 3. Dependency Injection
Use GetIt for service location:
```dart
// Register in app
getIt.registerFactory<ProductListViewModel>(
  () => ProductListViewModel(
    getProductsUseCase: getIt<GetProductsUseCase>(),
    themeService: getIt<ThemeService>(),
  ),
);

// Inject in widget
class ProductListPage extends StatelessWidget {
  final ProductListViewModel viewModel = getIt<ProductListViewModel>();
}
```

### 4. Testing Structure
```dart
// Unit tests - test business logic
void main() {
  group('GetProductsUseCase', () {
    test('should return products when repository succeeds', () async {
      // Arrange
      when(() => mockRepository.getProducts(any()))
          .thenAnswer((_) async => Right(mockProducts));
      
      // Act
      final result = await useCase.execute(request);
      
      // Assert
      expect(result.isRight(), true);
    });
  });
}
```

## Melos Commands
```yaml
# melos.yaml snippets
scripts:
  test:all:
    run: flutter test --coverage
    exec:
      concurrency: 3
      orderDependents: true
      
  analyze:all:
    run: flutter analyze
    exec:
      concurrency: 5
      failFast: true
```

## Design System Integration
```dart
// Use design tokens, not hard-coded values
Container(
  color: themeService.getCurrentColorTokens().surface,
  child: Text(
    'Hello',
    style: themeService.getCurrentTypographyTokens().bodyLarge,
  ),
)
```

## SOLID Principles Enforcement

### Single Responsibility Principle (SRP)
Each class has **exactly one reason to change**:
```dart
// ✅ Correct - Repository only handles data access
class ProductRepositoryImpl implements ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts() async { /* */ }
}

// ✅ Correct - Use case only handles business logic  
class GetProductsUseCase {
  Future<Either<Failure, ProductListResult>> execute() async { /* */ }
}

// ✅ Correct - ViewModel only handles presentation logic
class ProductListViewModel {
  void loadProducts() async { /* */ }
}

// ❌ Wrong - Repository doing validation AND data access
class ProductRepositoryImpl {
  Future<List<Product>> getProducts(String query) async {
    if (query.length < 3) throw ValidationError(); // SRP violation
    return api.getProducts(query);
  }
}
```

### Open/Closed Principle (OCP)
Open for extension, closed for modification:
```dart
// ✅ Correct - Abstract payment processor
abstract class PaymentProcessor {
  Future<Either<PaymentFailure, PaymentResult>> processPayment(Payment payment);
}

// ✅ Extend without modifying existing code
class StripePaymentProcessor implements PaymentProcessor { /* */ }
class PayPalPaymentProcessor implements PaymentProcessor { /* */ }

// ✅ Use strategy pattern for extensibility
class CheckoutUseCase {
  final PaymentProcessor paymentProcessor; // Inject specific implementation
}
```

### Liskov Substitution Principle (LSP)
Subclasses must be substitutable for base classes:
```dart
// ✅ Correct - All implementations follow contract
abstract class ProductDataSource {
  Future<List<Product>> getProducts();
}

class RemoteProductDataSource implements ProductDataSource {
  @override
  Future<List<Product>> getProducts() async {
    // Always returns List<Product>, never throws unexpected exceptions
  }
}

// ❌ Wrong - Violates LSP by changing behavior
class CachedProductDataSource implements ProductDataSource {
  @override  
  Future<List<Product>> getProducts() async {
    throw UnimplementedError(); // Breaks substitutability
  }
}
```

### Interface Segregation Principle (ISP)
Clients shouldn't depend on interfaces they don't use:
```dart
// ✅ Correct - Focused, specific interfaces
abstract class ProductReader {
  Future<List<Product>> getProducts();
}

abstract class ProductWriter {
  Future<void> saveProduct(Product product);
}

abstract class ProductCache {
  Future<void> clearCache();
}

// ✅ Implement only what you need
class ReadOnlyProductRepository implements ProductReader {
  // Only implements reading, not writing or caching
}

// ❌ Wrong - Fat interface forcing unused methods
abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<void> clearCache();
  Future<void> syncWithServer();
  // Read-only implementations forced to implement write methods
}
```

### Dependency Inversion Principle (DIP)
Depend on abstractions, not concretions:
```dart
// ✅ Correct - Depends on abstraction
class GetProductsUseCase {
  final ProductRepository repository; // Abstract interface
  
  const GetProductsUseCase(this.repository);
}

// ✅ Inject concrete implementation via DI
getIt.registerFactory<GetProductsUseCase>(
  () => GetProductsUseCase(getIt<ProductRepository>()),
);

// ❌ Wrong - Depends on concrete implementation  
class GetProductsUseCase {
  final ProductRepositoryImpl repository; // Concrete class
}
```

## Code Quality & Linting (STRICT)

### very_good_analysis Rules - ZERO TOLERANCE
All code must pass with **absolutely zero issues**:

```yaml
# analysis_options.yaml (root) - STRICT CONFIGURATION
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.mocks.dart"
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  errors:
    # Treat warnings as errors
    missing_return: error
    dead_code: error
    unused_import: error
    unused_local_variable: error
    prefer_const_constructors: error
    prefer_final_fields: error

linter:
  rules:
    # Disable only essential conflicting rules
    public_member_api_docs: false
    sort_pub_dependencies: false
    # All other very_good_analysis rules remain active
```

### Mandatory Compliance Rules
**Constructor Standards:**
```dart
// ✅ REQUIRED - const constructors with super parameters
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });
  
  final Product product;
  final VoidCallback? onTap;
}
```

**Field Standards:**
```dart
// ✅ REQUIRED - final fields, const values, proper initialization
class ProductViewModel {
  ProductViewModel({required ProductRepository repository})
      : _repository = repository;
      
  final ProductRepository _repository;
  static const int defaultPageSize = 20;
}

// ❌ FORBIDDEN - mutable fields without justification
class ProductViewModel {
  ProductRepository repository; // Missing final
  int pageSize = 20; // Should be const
}
```

**Method Standards:**
```dart
// ✅ REQUIRED - explicit return types, override annotations
class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await _dataSource.getProducts();
      return Right(products);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    }
  }
}

// ❌ FORBIDDEN - missing return types, empty catches
Future getProducts() async {
  try {
    return await _dataSource.getProducts();
  } catch (e) {
    // Empty catch block forbidden
  }
}
```

**Import Organization (STRICT ORDER):**
```dart
// 1. Dart/Flutter SDK imports
import 'dart:async';
import 'package:flutter/material.dart';

// 2. External package imports (alphabetical)
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 3. Internal package imports (core -> shared -> features)
import 'package:core_design_system/core_design_system.dart';
import 'package:core_networking/core_networking.dart';
import 'package:shared_auth/shared_auth.dart';

// 4. Relative imports (alphabetical)
import '../domain/entities/product.dart';
import '../domain/repositories/product_repository.dart';
```

**Error Handling (ZERO EXCEPTIONS):**
```dart
// ✅ REQUIRED - explicit error handling with Either
Future<Either<Failure, Product>> getProduct(String id) async {
  try {
    final product = await _api.getProduct(id);
    return Right(product);
  } on NetworkException catch (e) {
    return Left(NetworkFailure(e.message));
  } on ValidationException catch (e) {
    return Left(ValidationFailure(e.errors));
  }
}

// ❌ FORBIDDEN - unhandled exceptions
Future<Product> getProduct(String id) async {
  return await _api.getProduct(id); // Can throw unhandled exception
}
```

**Documentation (MANDATORY):**
```dart
/// Repository implementation for product data management.
/// 
/// Provides caching, error handling, and data synchronization
/// between remote and local data sources.
class ProductRepositoryImpl implements ProductRepository {
  /// Creates a repository with the given data sources.
  const ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// Remote API data source for product information.
  final ProductRemoteDataSource remoteDataSource;
  
  /// Local cache data source for offline access.
  final ProductLocalDataSource localDataSource;
}
```

## Remember
- **Zero lint issues required** - all code must pass very_good_analysis
- **No business logic in views** - everything goes in ViewModels
- **Features cannot depend on other features** - use shared packages
- **Use Freezed for all data classes** - immutability by default
- **Use Either for error handling** - no exceptions for business logic
- **Build complete widgets in ViewModels** - views just display them
- **Export only public APIs from packages** - hide implementation details