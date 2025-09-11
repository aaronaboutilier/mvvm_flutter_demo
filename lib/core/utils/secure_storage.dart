import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  Future<void> store(String key, String value);
  Future<String?> retrieve(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class FlutterSecureStorageService implements SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
  );

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();

  @override
  Future<String?> retrieve(String key) => _storage.read(key: key);

  @override
  Future<void> store(String key, String value) => _storage.write(key: key, value: value);
}
