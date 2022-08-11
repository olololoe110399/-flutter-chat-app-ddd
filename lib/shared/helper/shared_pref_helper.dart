import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class SharedPrefHelper {
  late SharedPreferences _preferences;
  static final SharedPrefHelper _singleton = SharedPrefHelper();

  // user id

  String get userId =>
      _preferences.getString(
        SharedPreferencesConstants.userId,
      ) ??
      '';

  set userId(String value) => _preferences.setString(
        SharedPreferencesConstants.userId,
        value,
      );

  // user token

  String get userToken =>
      _preferences.getString(
        SharedPreferencesConstants.userToken,
      ) ??
      '';

  set userToken(String value) => _preferences.setString(
        SharedPreferencesConstants.userToken,
        value,
      );

  // device token

  String get deviceToken =>
      _preferences.getString(
        SharedPreferencesConstants.deviceToken,
      ) ??
      '';

  set deviceToken(String value) => _preferences.setString(
        SharedPreferencesConstants.deviceToken,
        value,
      );

  static SharedPrefHelper get instance => _singleton;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
}
