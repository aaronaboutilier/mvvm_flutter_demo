# Clean Architecture Migration Guide
## Flutter MVVM to Feature-First Organization

---

## 🎯 **Primary Objectives**

Transform your current Flutter codebase from basic MVVM to a feature-first, clean architecture approach that maintains MVVM for presentation while introducing proper separation of concerns and dependency management.

### **Success Metrics**
- Clear separation between business logic and infrastructure concerns
- Testable, maintainable code with proper abstraction layers
- Scalable feature organization that supports team collaboration
- Reduced coupling between components through dependency inversion

---

## 📁 **Target Architecture Structure**

### **Proposed Organization**
```
lib/
├── core/                    # Shared foundation
│   ├── errors/             # Domain failures & exceptions
│   ├── result/             # Result<Success, Failure> types
│   ├── utils/              # Common utilities
│   ├── usecase_base/       # Base use case abstractions
│   ├── theming/            # UI theme configuration
│   └── env/                # Environment configuration
│
└── features/               # Feature-based organization
    ├── home/
    │   ├── domain/         # Business entities & rules
    │   ├── application/    # Use cases & orchestration
    │   ├── infrastructure/ # Data sources & implementations
    │   └── presentation/   # ViewModels & Views (MVVM)
    │
    ├── settings/
    └── details/
```

### **Migration Mapping**
| Current Structure | Target Location | Purpose |
|-------------------|-----------------|---------|
| `models/` | `domain/entities/` + `domain/value_objects/` | Business objects |
| `services/` | `infrastructure/datasources/` + `infrastructure/repository_impl/` | External concerns |
| `viewmodels/` | `presentation/viewmodels/` | MVVM presentation logic |
| `views/` | `presentation/views/` | UI components |
| `app_config/` | `domain/entities/` + `infrastructure/dto/` | Configuration management |

---

## 🏗️ **Layer Responsibilities**

### **Domain Layer**
**Purpose**: Pure business logic and rules
- **Contains**: Entities, Value Objects, Repository interfaces, Domain failures
- **Restrictions**: No Flutter imports, no HTTP, no JSON dependencies
- **Goal**: Represent business concepts in their purest form

### **Application Layer**
**Purpose**: Use case orchestration and business workflow coordination
- **Contains**: Use cases that orchestrate domain logic
- **Characteristics**: Thin, stateless, depends only on domain abstractions
- **Goal**: Define how the application responds to user intentions

### **Infrastructure Layer**
**Purpose**: Handle external system interactions and technical implementation details
- **Contains**: Data sources, DTOs, repository implementations, API clients
- **Responsibility**: Map between external data formats and domain objects
- **Goal**: Isolate technical complexity from business logic

### **Presentation Layer**
**Purpose**: MVVM implementation for user interface concerns
- **Contains**: ViewModels that depend on use cases, Views that depend on ViewModels
- **Restriction**: No direct infrastructure dependencies
- **Goal**: Present data and handle user interactions through clean abstractions

---

## 🔧 **Essential Patterns to Implement**

### **Base Use Case Pattern**
Establish consistency across all application layer components:
```dart
abstract class UseCase<Type, Params> {
  Future<Result<Type, Failure>> call(Params params);
}
```

### **Value Object Implementation**
Encapsulate business rules and prevent invalid states:
- `NonEmptyString` for required text fields
- `Email` for validated email addresses
- `Url` for validated web addresses
- `UserId` for type-safe identifiers

### **Unified Error Handling**
Implement domain-specific failure types:
- `NetworkFailure` for connectivity issues
- `ValidationFailure` for business rule violations
- `ConfigFailure` for configuration problems
- `NotFoundFailure` for missing resources

### **Result Type Usage**
Adopt functional error handling with `Result<Success, Failure>` pattern using either fpdart's Either type or a custom Result implementation.

---

## ⚙️ **SOLID Principles Application**

### **Single Responsibility Principle (SRP)**
- Split current services into focused data sources and repository implementations
- Separate models into distinct entities, value objects, and DTOs
- Each class should have one clear reason to change

### **Open/Closed Principle (OCP)**
- New data sources can be added through interface implementation
- ViewModels remain unchanged when adding new infrastructure options

### **Liskov Substitution Principle (LSP)**
- Repository implementations must be completely substitutable for their interfaces
- Maintain stable domain types across all implementations

### **Interface Segregation Principle (ISP)**
- Design focused interfaces such as `ConfigRepository {load, save}`
- Avoid monolithic service interfaces that force unnecessary dependencies

### **Dependency Inversion Principle (DIP)**
- ViewModels depend on use case abstractions rather than concrete implementations
- Use dependency injection to wire concrete infrastructure components

---

## 🔌 **Dependency Injection Strategy**

### **Recommended Approaches**
- **Option A**: `get_it` + `injectable` for classic dependency injection
- **Option B**: `riverpod` for integrated DI and state management

### **Registration Pattern**
```
Infrastructure Level:
├── Data sources (concrete implementations)
├── Repository implementations (as interface types)

Application Level:
├── Use cases (as factories)

Presentation Level:
└── ViewModels (as factories)
```

### **Key Constraint**
Presentation layer components must never import infrastructure layer modules directly.

---

## 📋 **Implementation Checklist**

### **Code Quality Standards**
- [ ] Prefer `final` and `const` declarations for immutability
- [ ] Implement immutable entities and value objects
- [ ] Maintain small, focused files with one public type per file
- [ ] Use meaningful names that clearly indicate purpose
- [ ] Eliminate Flutter imports from domain and application layers
- [ ] Remove business logic from infrastructure components
- [ ] Replace static singletons with dependency injection
- [ ] Keep ViewModels focused on use case orchestration only

### **Error Handling Requirements**
- [ ] Implement unified Failure model with clear categories
- [ ] Return Result/Either types from repositories and use cases
- [ ] Map technical errors to user-friendly messages only in ViewModels
- [ ] Eliminate direct try/catch of HTTP exceptions in presentation layer

---

## 🧪 **Testing Strategy**

### **Domain Layer Testing**
- Unit test value objects with invalid input scenarios
- Verify entity invariants and business rules
- Test use cases with mocked repository dependencies

### **Infrastructure Layer Testing**
- Test DTO mapping accuracy with golden JSON samples
- Verify repository implementations with fake data sources
- Implement contract tests to ensure all implementations meet behavioral requirements

### **Presentation Layer Testing**
- Test ViewModel logic for both success and error scenarios
- Create widget tests for view components
- Verify proper state management and user interaction handling

---

## 🚀 **Incremental Migration Plan**

### **Phase 1: Foundation Setup**
1. Create core directory structure with shared utilities
2. Define base use case abstractions and result types
3. Establish failure hierarchy and error handling patterns

### **Phase 2: Feature Migration (Per Feature)**
1. **Select Target Feature**: Start with a self-contained feature like details
2. **Extract Domain Objects**: Move models to `features/details/domain/entities`
3. **Define Repository Interface**: Create abstraction in domain layer
4. **Implement Infrastructure**: Move service logic to data sources and repository implementations
5. **Create Use Cases**: Add application layer orchestration
6. **Refactor Presentation**: Update ViewModels to depend on use cases
7. **Update Dependency Injection**: Wire new components together

### **Phase 3: Integration and Cleanup**
1. Remove deprecated service dependencies
2. Verify test coverage across all layers
3. Validate SOLID principle adherence
4. Optimize dependency injection configuration

---

## 📦 **Recommended Packages**

### **Core Architecture Support**
- `freezed` + `freezed_annotation` - Immutable classes and union types
- `json_serializable` - DTO serialization and deserialization
- `equatable` - Value equality implementation (if not using freezed)

### **Dependency Management**
- `get_it` + `injectable` - Service locator and dependency injection
- `riverpod` - State management with integrated dependency injection

### **Functional Programming**
- `fpdart` - Either/Option types for functional error handling

---

## 🎖️ **Success Indicators**

### **Short-term Wins**
- Clear separation between business logic and technical implementation
- Improved testability through dependency injection
- Reduced coupling between presentation and infrastructure layers

### **Long-term Benefits**
- Scalable feature organization that supports team growth
- Maintainable codebase with predictable structure
- Enhanced ability to adapt to changing business requirements
- Improved developer productivity through clear architectural boundaries

---

*This guide provides a structured approach to evolving your Flutter application architecture while maintaining MVVM benefits and introducing clean architecture principles for long-term maintainability and scalability.*