import 'package:test_project/api/pref_keys.dart';
import 'package:test_project/api/prefs.dart';

class PrefsHelper {
  static final PrefsHelper _helper = PrefsHelper._internal();

  factory PrefsHelper() {
    return _helper;
  }

  PrefsHelper._internal();

  /* GETTERS */

  /* COMMENTS */
  String get comment1 => Prefs.getString(PrefKeys.kComment1) ?? "";
  bool get comment1AlreadyDone =>
      Prefs.getBool(PrefKeys.kComment1Done) ?? false;
  double get numberOfCommentActivitiesDone =>
      Prefs.getDouble(PrefKeys.kNumberOfCommentActivitiesDone) ?? 0.0;
  double get currentCommentScroll =>
      Prefs.getDouble(PrefKeys.kCurrentCommentScroll) ?? 0.0;

  /* PRINT */
  String get print1 => Prefs.getString(PrefKeys.kPrint1) ?? "";
  String get print2 => Prefs.getString(PrefKeys.kPrint2) ?? "";

  bool get print1AlreadyDone => Prefs.getBool(PrefKeys.kPrint1Done) ?? false;
  bool get print2AlreadyDone => Prefs.getBool(PrefKeys.kPrint2Done) ?? false;

  double get numberOfPrintActivitiesDone =>
      Prefs.getDouble(PrefKeys.kNumberOfPrintActivitiesDone) ?? 0.0;
  double get currentPrintScroll =>
      Prefs.getDouble(PrefKeys.kCurrentPrintScroll) ?? 0.0;

  String get accountName => Prefs.getString(PrefKeys.kAccountName) ?? "";
  int get timeElapsedInLesson => Prefs.getInt(PrefKeys.kTimeElapsed) ?? 0;

  /* SETTERS */

  /* COMMENTS */
  set comment1(String value) => Prefs.setString(PrefKeys.kComment1, value);
  set comment1AlreadyDone(bool value) =>
      Prefs.setBool(PrefKeys.kComment1Done, value);
  set numberOfCommentActivitiesDone(double value) =>
      Prefs.setDouble(PrefKeys.kNumberOfCommentActivitiesDone, value);
  set currentCommentScroll(double value) =>
      Prefs.setDouble(PrefKeys.kCurrentCommentScroll, value);

  /* PRINT */
  set print1(String value) => Prefs.setString(PrefKeys.kPrint1, value);
  set print1AlreadyDone(bool value) =>
      Prefs.setBool(PrefKeys.kPrint1Done, value);

  set print2(String value) => Prefs.setString(PrefKeys.kPrint2, value);
  set print2AlreadyDone(bool value) =>
      Prefs.setBool(PrefKeys.kPrint2Done, value);

  set numberOfPrintActivitiesDone(double value) =>
      Prefs.setDouble(PrefKeys.kNumberOfPrintActivitiesDone, value);
  set currentPrintScroll(double value) =>
      Prefs.setDouble(PrefKeys.kCurrentPrintScroll, value);

  set accountName(String value) =>
      Prefs.setString(PrefKeys.kAccountName, value);
  set timeElapsedInLesson(int value) =>
      Prefs.setInt(PrefKeys.kTimeElapsed, value);
}
