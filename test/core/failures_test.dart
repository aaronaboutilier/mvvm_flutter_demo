import 'package:flutter_test/flutter_test.dart';
import 'package:core_foundation/core/errors/failures.dart';
import 'package:core_foundation/core/utils/error_mapper.dart';

void main() {
  group('Failures', () {
    test('NetworkFailure keeps statusCode and defaults code', () {
      const f = NetworkFailure(message: 'timeout', statusCode: 408);
      expect(f.code, 'network');
      expect(f.statusCode, 408);
    });

    test('ValidationFailure stores field errors', () {
      const f = ValidationFailure(message: 'invalid', fieldErrors: {'email': 'bad'});
      expect(f.code, 'validation');
      expect(f.fieldErrors?['email'], 'bad');
    });
  });

  group('ErrorMapper', () {
    test('passes through Failure instances', () {
      const failure = UnknownFailure(message: 'x');
      final mapped = ErrorMapper.map(failure);
      expect(identical(mapped, failure), true);
    });

    test('maps unknown error to UnknownFailure', () {
      final mapped = ErrorMapper.map(ArgumentError('bad'));
      expect(mapped is UnknownFailure, true);
    });
  });
}
