import 'package:flutter_test/flutter_test.dart';

import 'package:mvvm_flutter_demo/core/result/result.dart';
import 'package:mvvm_flutter_demo/core/errors/failure.dart';

class _DummyFailure extends Failure {
  const _DummyFailure(String message) : super(message: message, code: 'dummy');
}

void main() {
  group('Result', () {
    test('Success.fold returns success branch', () {
      const result = Success<int>(42);
      final value = result.fold(
        failure: (_) => -1,
        success: (v) => v + 1,
      );
      expect(value, 43);
    });

    test('FailureResult.fold returns failure branch', () {
      const failure = _DummyFailure('oops');
      const result = FailureResult<int>(failure);
      final msg = result.fold(
        failure: (f) => f.message,
        success: (_) => 'nope',
      );
      expect(msg, 'oops');
    });
  });
}
