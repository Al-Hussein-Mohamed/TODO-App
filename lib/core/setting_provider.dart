import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/firebase_utils.dart';

import '../features/tasks/tasks_view.dart';
import 'application_theme_manager.dart';

class SettingProvider extends ChangeNotifier {
  String curLanguage = "en";
  ThemeMode curTheme = ThemeMode.light;
  DateTime focusDate = DateTime.now();
  final EasyInfiniteDateTimelineController controller =
      EasyInfiniteDateTimelineController();

  void changeLanguage(String newLanguage) {
    if (curLanguage == newLanguage) return;
    curLanguage = newLanguage;
    saveLanguage(newLanguage);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (curTheme == newTheme) return;
    curTheme = newTheme;
    saveTheme(newTheme);
    notifyListeners();
  }

  void saveLanguage(String newLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", newLanguage);
  }

  void saveTheme(ThemeMode newTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "theme", newTheme == ThemeMode.light ? "light" : "dark");
  }

  void getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    curLanguage = prefs.getString("language") ?? "en";
    notifyListeners();
  }

  void changeDate(DateTime date) {
    focusDate = date;
    controller.animateToDate(focusDate);
    notifyListeners();
  }

  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("theme") == null ||
        prefs.getString("theme")! == "light") {
      curTheme = ThemeMode.light;
    } else {
      curTheme = ThemeMode.dark;
    }
    notifyListeners();
  }

  bool isEn() {
    return (curLanguage == "en");
  }

  bool isDark() {
    return (curTheme == ThemeMode.dark);
  }
}
