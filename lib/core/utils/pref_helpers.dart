import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  static const String _tokenKey = 'auth_token';

  static Future<SharedPreferences> _prefs() async =>
      await SharedPreferences.getInstance();

  static Future<void> saveToken(String token) async {
    final pref = await _prefs();
    await pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await _prefs();
    return pref.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final pref = await _prefs();
    await pref.remove(_tokenKey);
  }
}
