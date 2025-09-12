import 'entities/session.dart';

abstract class AuthRepository {
  Future<Session?> getCurrentSession();
  Future<Session> signIn({required String username, required String password});
  Future<void> signOut();
}
