import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setBoolean(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  bool? getBoolean(String key) {
    return _preferences.getBool(key);
  }

  void remove(String key) async {
    await _preferences.remove(key);
  }
}
