import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  final SharedPreferences prefs;

  CacheManager(this.prefs);

  /// Save string value by key
  Future<bool> setString(String key, String value) async {
    final result = await prefs.setString(key, value);

    return result;
  }

  /// Get string value by key
  String? getString(String key) {
    return prefs.getString(key);
  }
}
