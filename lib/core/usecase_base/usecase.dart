import '../errors/failure.dart';
import '../result/result.dart';
import 'package:core_foundation/core/usecase_base/usecase.dart' as core;

/// Base Use Case contract. All use cases should implement this interface.
abstract class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

/// A convenience type for use cases that do not require params.
///
/// Alias to the canonical type from core_foundation to ensure a single
/// NoParams type is used across app and feature packages.
typedef NoParams = core.NoParams;

/// A convenience failure for unimplemented or unsupported use cases.
class UnimplementedFailure extends Failure {
  const UnimplementedFailure(String message)
      : super(message: message, code: 'unimplemented');
}
