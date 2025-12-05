import 'package:caffeine/core/constants/app_constats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  static const String _keyOnboardingSeen = 'onboarding_seen';
  static const String _token = 'token';

  final SharedPreferences _prefs;

  PrefHelpers(this._prefs);

  Future<void> setOnboardingSeen() async {
    await _prefs.setBool(_keyOnboardingSeen, true);
  }

  bool isOnboardingSeen() {
    return _prefs.getBool(_keyOnboardingSeen) ?? false;
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_token, token);
  }

  String getToken() {
    return _prefs.getString(_token) ?? AppConstats.annoneKey;
  }
}
