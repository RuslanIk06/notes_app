import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? _preferences;

  static const String _username = 'username';
  static const String _password = 'password';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername({
    required String username,
    required String password,
  }) async {
    await _preferences!.setString(_username, username);
    await _preferences!.setString(_password, password);
  }

  static String? getUsername() => _preferences!.getString(_username);
  static String? getPassword() => _preferences!.getString(_username);
}
