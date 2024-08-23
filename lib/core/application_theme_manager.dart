import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/setting_provider.dart';

class ApplicationThemeManager{
  static const Color primaryColor = Color(0xFF5D9CEC);
  static ThemeData light(bool isEn){
    return ThemeData(
      fontFamily: isEn ? "Poppins" : "Cairo",
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFDFECDB),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        toolbarHeight: 140,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          selectedIconTheme: IconThemeData(
            color: primaryColor,
            size: 32,
          ),
          unselectedIconTheme: IconThemeData(
            size: 28,
          )),
      // scaffoldBackgroundColor: Colors.transparent,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        displayLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
  static ThemeData dark(bool isEn){
    return ThemeData(
      fontFamily: isEn ? "Poppins" : "Cairo",
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF040A15),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        toolbarHeight: 140,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          selectedIconTheme: IconThemeData(
            color: primaryColor,
            size: 32,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.white,
            size: 28,
          )),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: primaryColor,
        ),
        displayLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
