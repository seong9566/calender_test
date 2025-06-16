import 'package:calender_test/core/storage/prefrences_helper.dart';

class SharedPreferenceUtil {
  static final SharedPreferenceUtil _prefs = SharedPreferenceUtil._internal();

  factory SharedPreferenceUtil() {
    return _prefs;
  }

  SharedPreferenceUtil._internal();

  Future clear() => PreferencesHelper().clearPrefs();
}
