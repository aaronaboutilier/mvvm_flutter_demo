# ADR 0001: Architecture and Practices

Date: 2025-09-11

Status: Accepted

Context

We standardize on Clean Architecture with MVVM, immutable view states, typed failures, a Result type, environment-driven configuration, structured logging, and comprehensive testing (including goldens).

Decision

- Result type (core/result) is used across repositories and use cases.
- Failures are explicit (core/errors) and mapped via ErrorMapper.
- View states are immutable; Freezed is used for data classes.
- App configuration is centralized (core/configuration) with persistence.
- Logger interface added with DebugLogger as default.
- PerformanceMonitor tracks durations with structured logs.
- Secure storage abstraction added.
- Analysis uses very_good_analysis with generated files excluded.

Consequences

- Requires build_runner to generate Freezed/JSON code.
- Tests should use Result helpers and validate both success and failure paths.
