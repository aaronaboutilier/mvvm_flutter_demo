import 'package:shared_preferences/shared_preferences.dart';

abstract class KeyValueStore {
  Future<bool> setString(String key, String value);
  String? getString(String key);
}

class SharedPrefsStore implements KeyValueStore {
  SharedPrefsStore(this._prefs);
  final SharedPreferences _prefs;

  static Future<SharedPrefsStore> create() async => SharedPrefsStore(await SharedPreferences.getInstance());

  @override
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  @override
  String? getString(String key) => _prefs.getString(key);
}
