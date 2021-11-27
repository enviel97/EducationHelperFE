import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _preferences;
  const LocalStorage(this._preferences);

  Future<String> read(String key) async {
    final value = _preferences.getString(key);
    return value ?? '';
  }

  Future<bool> write(String key, String value) async {
    final bool result = await _preferences.setString(key, value);
    return result;
  }
}
