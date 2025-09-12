// Re-export canonical Result extensions from core_foundation
export 'package:core_foundation/core/result/result_extensions.dart';

import 'package:core_foundation/core/result/result.dart';

// Backward-compatible convenience helpers used across the app/tests.
extension ResultXCompat<T> on Result<T> {
	// Transform the success value, if any.
	Result<R> map<R>(R Function(T v) fn) {
		final s = asSuccess;
		if (s != null) return Success<R>(fn(s.value));
		final f = asFailure!;
		return FailureResult<R>(f.failureValue);
	}

	// Chain another Result-producing function.
	Result<R> flatMap<R>(Result<R> Function(T v) fn) {
		final s = asSuccess;
		if (s != null) return fn(s.value);
		final f = asFailure!;
		return FailureResult<R>(f.failureValue);
	}

	// Returns the success value or null.
	T? getOrNull() => asSuccess?.value;

	// Returns the success value or a fallback.
	T getOrElse(T Function() orElse) => asSuccess?.value ?? orElse();
}
