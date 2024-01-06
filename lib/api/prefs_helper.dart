import 'package:test_project/api/pref_keys.dart';
import 'package:test_project/api/prefs.dart';

class PrefsHelper {
  static final PrefsHelper _helper = PrefsHelper._internal();

  factory PrefsHelper() {
    return _helper;
  }

  PrefsHelper._internal();

  String get comment_1 => Prefs.getString(PrefKeys.kComment1) ?? "";

  String get comment_2 => Prefs.getString(PrefKeys.kComment2) ?? "";

  String get accountName => Prefs.getString(PrefKeys.kAccountName) ?? "";

  int get timeElapsedInLesson => Prefs.getInt(PrefKeys.kTimeElapsed) ?? 0;

  double get currentScroll => Prefs.getDouble(PrefKeys.kCurrentScroll) ?? 0.0;

  set comment_1(String value) => Prefs.setString(PrefKeys.kComment1, value);

  set comment_2(String value) => Prefs.setString(PrefKeys.kComment2, value);

  set accountName(String value) =>
      Prefs.setString(PrefKeys.kAccountName, value);

  set currentScroll(double value) =>
      Prefs.setDouble(PrefKeys.kCurrentScroll, value);

  set timeElapsedInLesson(int value) =>
      Prefs.setInt(PrefKeys.kTimeElapsed, value);
}
