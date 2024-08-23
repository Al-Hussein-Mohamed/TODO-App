import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application_theme_manager.dart';

class SettingProvider extends ChangeNotifier{
  String curLanguage = "en";
  ThemeMode curTheme = ThemeMode.light;

  void changeLanguage(String newLanguage){
    if(curLanguage == newLanguage)  return;
    curLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme){
    if(curTheme == newTheme)  return;
    curTheme = newTheme;
    notifyListeners();
  }

  bool isEn(){
    return (curLanguage == "en");
  }

  bool isDark(){
    return (curTheme == ThemeMode.dark);
  }
}