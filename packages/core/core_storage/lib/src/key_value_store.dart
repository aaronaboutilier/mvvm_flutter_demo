import 'package:shared_preferences/shared_preferences.dart';

/// Interface for a key-value store.
abstract class KeyValueStore {
  /// Sets a string value for the given [key].
  Future<bool> setString(String key, String value);

  /// Gets a string value for the given [key].
  String? getString(String key);
}

/// Implementation of [KeyValueStore] using [SharedPreferences].
class SharedPrefsStore implements KeyValueStore {
  /// Creates a [SharedPrefsStore] with the given [SharedPreferences].
  SharedPrefsStore(this._prefs);

  /// The underlying [SharedPreferences] instance.
  final SharedPreferences _prefs;

  /// Creates a [SharedPrefsStore] asynchronously.
  static Future<SharedPrefsStore> create() async =>
      SharedPrefsStore(await SharedPreferences.getInstance());

  /// Sets a string value for the given [key].
  @override
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  /// Gets a string value for the given [key].
  @override
  String? getString(String key) => _prefs.getString(key);
}
