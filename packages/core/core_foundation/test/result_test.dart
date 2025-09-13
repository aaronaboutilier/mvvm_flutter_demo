import 'package:core_foundation/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result core', () {
    test('ok and err factories', () {
      final ok = Result.ok(1);
      expect(ok.isSuccess, isTrue);
      expect(ok.asSuccess!.value, 1);

      final err = Result.err<int>(const UnknownFailure(message: 'x'));
      expect(err.isFailure, isTrue);
      expect(err.asFailure!.failureValue.code, 'unknown');
    });

    test('map/flatMap', () {
      final r = Result.ok(2).map((v) => v * 2).flatMap((v) => Result.ok(v + 1));
      expect(r.asSuccess!.value, 5);

      final f = Result.err<int>(
        const ValidationFailure(message: 'bad'),
      ).map((v) => v * 10);
      expect(f.isFailure, isTrue);
      expect(f.asFailure!.failureValue.code, 'validation');
    });

    test('mapFailure/recover', () {
      final r = Result.err<int>(const ValidationFailure(message: 'bad'))
          .mapFailure((f) => const ConfigFailure(message: 'cfg'))
          .recover((f) => 42);
      expect(r.asSuccess!.value, 42);
    });

    test('getOrThrow throws failure', () {
      final r = Result.err<int>(const NotFoundFailure(message: 'nope'));
      expect(r.getOrThrow, throwsA(isA<Failure>()));
    });
  });

  group('Result async', () {
    test('resultGuard wraps success', () async {
      final r = await resultGuard(() async => 'ok');
      expect(r.isSuccess, isTrue);
      expect(r.asSuccess!.value, 'ok');
    });

    test('resultGuard wraps exception to Failure', () async {
      final r = await resultGuard(() async => throw Exception('boom'));
      expect(r.isFailure, isTrue);
      expect(r.asFailure!.failureValue, isA<Failure>());
    });

    test('mapAsync/flatMapAsync', () async {
      final r = await Future.value(Result.ok(2))
          .mapAsync((int v) async => v * 3)
          .flatMapAsync((int v) async => Result.ok(v + 1));
      expect(r.asSuccess!.value, 7);
    });

    test('resultGuardSync wraps sync exceptions', () async {
      final r = resultGuardSync<int>(() => throw Exception('boom'));
      expect(r.isFailure, isTrue);
    });
  });
}
