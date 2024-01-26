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
  String get print3 => Prefs.getString(PrefKeys.kPrint3) ?? "";

  bool get print1AlreadyDone => Prefs.getBool(PrefKeys.kPrint1Done) ?? false;
  bool get print2AlreadyDone => Prefs.getBool(PrefKeys.kPrint2Done) ?? false;
  bool get print3AlreadyDone => Prefs.getBool(PrefKeys.kPrint3Done) ?? false;

  double get numberOfPrintActivitiesDone =>
      Prefs.getDouble(PrefKeys.kNumberOfPrintActivitiesDone) ?? 0.0;
  double get currentPrintScroll =>
      Prefs.getDouble(PrefKeys.kCurrentPrintScroll) ?? 0.0;

  String get accountName => Prefs.getString(PrefKeys.kAccountName) ?? "";

  // TIME STUFF
  int get timeElapsedInLesson => Prefs.getInt(PrefKeys.kTimeElapsed) ?? 0;
  double get timeElapsedMonday => Prefs.getDouble(PrefKeys.kTimeMonday) ?? 0.0;
  double get timeElapsedTuesday =>
      Prefs.getDouble(PrefKeys.kTimeTuesday) ?? 0.0;
  double get timeElapsedWednesday =>
      Prefs.getDouble(PrefKeys.kTimeWednesday) ?? 0.0;
  double get timeElapsedThursday =>
      Prefs.getDouble(PrefKeys.kTimeThursday) ?? 0.0;
  double get timeElapsedFriday => Prefs.getDouble(PrefKeys.kTimeFriday) ?? 0.0;
  double get timeElapsedSaturday =>
      Prefs.getDouble(PrefKeys.kTimeSaturday) ?? 0.0;
  double get timeElapsedSunday => Prefs.getDouble(PrefKeys.kTimeSunday) ?? 0.0;

  bool get randomImageChosen =>
      Prefs.getBool(PrefKeys.krandomImageChosen) ?? false;

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
  set print3(String value) => Prefs.setString(PrefKeys.kPrint3, value);
  set print3AlreadyDone(bool value) =>
      Prefs.setBool(PrefKeys.kPrint3Done, value);

  set numberOfPrintActivitiesDone(double value) =>
      Prefs.setDouble(PrefKeys.kNumberOfPrintActivitiesDone, value);
  set currentPrintScroll(double value) =>
      Prefs.setDouble(PrefKeys.kCurrentPrintScroll, value);

  // TIME STUFF
  set timeElapsedInLesson(int value) =>
      Prefs.setInt(PrefKeys.kTimeElapsed, value);
  set timeElapsedMonday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeMonday, value);
  set timeElapsedTuesday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeTuesday, value);
  set timeElapsedWednesday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeWednesday, value);
  set timeElapsedThursday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeThursday, value);
  set timeElapsedFriday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeFriday, value);
  set timeElapsedSaturday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeSaturday, value);
  set timeElapsedSunday(double value) =>
      Prefs.setDouble(PrefKeys.kTimeSunday, value);

  set accountName(String value) =>
      Prefs.setString(PrefKeys.kAccountName, value);

  set randomImageChosen(bool value) =>
      Prefs.setBool(PrefKeys.krandomImageChosen, value);
}
