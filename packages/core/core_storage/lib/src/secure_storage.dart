import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interface for secure key-value storage.
abstract class SecureStorageService {
  /// Stores a [value] for the given [key].
  Future<void> store(String key, String value);

  /// Retrieves the value for the given [key].
  Future<String?> retrieve(String key);

  /// Deletes the value for the given [key].
  Future<void> delete(String key);

  /// Deletes all stored values.
  Future<void> deleteAll();
}

/// Implementation of [SecureStorageService] using [FlutterSecureStorage].
class FlutterSecureStorageService implements SecureStorageService {
  /// The underlying [FlutterSecureStorage] instance.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Deletes the value for the given [key].
  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Deletes all stored values.
  @override
  Future<void> deleteAll() => _storage.deleteAll();

  /// Retrieves the value for the given [key].
  @override
  Future<String?> retrieve(String key) => _storage.read(key: key);

  /// Stores a [value] for the given [key].
  @override
  Future<void> store(String key, String value) =>
      _storage.write(key: key, value: value);
}
