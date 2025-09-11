High-level structure (feature-first, MVVM-friendly)

Keep MVVM for presentation, but organize per feature and layer your code inside each feature.
Example:
lib/
core/ (shared: errors, result, utils, usecase base, theming, env)
features/
home/
domain/ (entities, value_objects, repositories)
application/ (use_cases)
infrastructure/ (datasources, dtos, repository_impl)
presentation/ (viewmodels, views)
settings/…
details/…
Your current:
models → domain/entities (+ value_objects)
services → infrastructure/datasources or repositories_impl
viewmodels → presentation/viewmodels
views → presentation/views
app_config → domain entity + infra DTO + datasource (config)
Responsibilities by layer

Domain: Pure business objects and rules. No Flutter, no HTTP, no JSON. Entities, Value Objects, Repository ABIs, Failures.
Application: Use cases orchestrating domain logic. Thin, stateless; depend only on domain abstractions.
Infrastructure: IO details. Datasources (HTTP, storage), DTOs, repository implementations that map DTO ↔ domain.
Presentation (your MVVM): ViewModels depend on use cases only; Views depend on ViewModels.
Small patterns to adopt

Base use case (keeps app layer consistent)

Input: Params type
Output: Result<Success, Failure> (Either-like)
Value Object (encapsulate invariants, avoid “naked” primitives)

Example: NonEmptyString, Email, Url, UserId
Failures

Domain-specific Failures (ConfigFailure, NetworkFailure, ValidationFailure)
Result type

Use fpdart Either or define a tiny Result<Ok, Err>.
 next steps.

SOLID quick checks

SRP: One class, one reason to change (split your current services into ds/repo mapping; split models into entities/vo/dto).
OCP: New datasource? Add a new class implementing the same repository interface—no need to modify ViewModels.
LSP: Implementations must be substitutable for repository interfaces (keep domain types stable).
ISP: Prefer small interfaces (e.g., ConfigRepository {load, save} vs one mega service).
DIP: ViewModels depend on use case abstractions; use DI to wire concrete infra.
DI options

get_it + injectable (classic) or Riverpod for DI + state.
Register:
datasources (infra)
repository impls (as UserRepository)
use cases (as factories)
viewmodels (factory)
Presentation never imports infrastructure.
Error and result handling

Use a unified Failure model with categories (network, notFound, validation, unknown).
Return Result/Either from repositories and use cases; map to UI-friendly strings in ViewModel only.
Clean code essentials for this codebase

Prefer final/const, immutable entities/value objects.
Keep files small; one public type per file; meaningful names (no “Service” where “Repository” or “DataSource” is meant).
No Flutter imports in domain/application.
No JSON or HTTP in domain/application; no business rules in infra.
Avoid static singletons; prefer DI.
Keep ViewModels thin: no mapping DTOs; no try/catch of HTTP; only orchestrate use cases and expose UI state.
Lint: enable strict lints (e.g., very_good_analysis or flutter_lints + rules for immutability, prefer_const).
Testing strategy

Domain: unit-test value objects (invalid inputs), entities invariants, use cases (with mocked repositories).
Infrastructure: test DTO mapping and repository impls with fakes; golden JSON samples.
Presentation: ViewModel tests (happy path + error); widget tests for views.
Add fast “contract tests” for repositories to ensure all impls meet behavior.
Incremental migration (low-risk)

Pick one feature (e.g., details):
Extract domain entity/value objects from models/ into features/details/domain.
Define repository interface in domain.
Move current service to infra datasource + repository impl; add DTO mapping.
Create a use case in application.
Refactor details_viewmodel.dart to depend on the use case; update DI.
Repeat per feature; delete old service usages as you migrate.
Helpful packages (optional)

freezed + freezed_annotation (immutable classes + union states)
json_serializable (DTOs)
equatable (value equality) if not using freezed
get_it + injectable or riverpod
fpdart (Either/Option) or a tiny Result type