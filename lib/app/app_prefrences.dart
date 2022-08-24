// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_ISUSER_LOGGED_IN = "PREFS_KEY_ISUSER_LOGGED_IN";

class AppPrefrences {
  final SharedPreferences _sharedPreferences;
  AppPrefrences(
    this._sharedPreferences,
  );

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getLanguage();
    }
  }

//--------------------------------OnBoardin Screen--------------------------------
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //-----------------------------Login In Screen--------------------------------
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_ISUSER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_ISUSER_LOGGED_IN) ?? false;
  }
}
