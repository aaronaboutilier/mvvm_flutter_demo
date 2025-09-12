import 'package:flutter_test/flutter_test.dart';

import 'package:core_foundation/core/result/result.dart';
import 'package:core_foundation/core/result/result_extensions.dart';
import 'package:core_foundation/core/errors/failure.dart';

class _F extends Failure {
  const _F(String m) : super(message: m);
}

void main() {
  test('map transforms Success', () {
    const r = Success<int>(2);
    final mapped = r.map((v) => v * 3);
    expect(mapped.asSuccess?.value, 6);
  });

  test('map preserves Failure', () {
    const r = FailureResult<int>(_F('e'));
    final mapped = r.map((v) => v * 3);
    expect(mapped.isFailure, true);
  });

  test('flatMap chains success', () {
    const r = Success<int>(2);
    final chained = r.flatMap((v) => Success(v + 1));
    expect(chained.asSuccess?.value, 3);
  });

  test('flatMap short-circuits on failure', () {
    const r = FailureResult<int>(_F('e'));
    final chained = r.flatMap((v) => Success(v + 1));
    expect(chained.isFailure, true);
  });

  test('getOrElse and getOrNull', () {
    const ok = Success<int>(5);
    const err = FailureResult<int>(_F('e'));
    expect(ok.getOrNull(), 5);
    expect(err.getOrNull(), null);
    expect(ok.getOrElse(() => 0), 5);
    expect(err.getOrElse(() => 0), 0);
  });
}
