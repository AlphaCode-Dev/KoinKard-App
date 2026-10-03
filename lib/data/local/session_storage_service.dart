import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageService {
  SessionStorageService(this._preferences);

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';

  final SharedPreferences _preferences;

  String? get accessToken => _preferences.getString(_accessTokenKey);
  String? get refreshToken => _preferences.getString(_refreshTokenKey);
  String? get userId => _preferences.getString(_userIdKey);

  Future<bool> saveAccessToken(String token) {
    return _preferences.setString(_accessTokenKey, token);
  }

  Future<bool> saveRefreshToken(String token) {
    return _preferences.setString(_refreshTokenKey, token);
  }

  Future<bool> saveUserId(String userId) {
    return _preferences.setString(_userIdKey, userId);
  }

  Future<void> clearSession() async {
    await _preferences.remove(_accessTokenKey);
    await _preferences.remove(_refreshTokenKey);
    await _preferences.remove(_userIdKey);
  }
}
