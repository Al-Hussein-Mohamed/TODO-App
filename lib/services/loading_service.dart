import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading(bool isDark) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..backgroundColor = isDark ? const Color(0xFF141922) : Colors.white
    ..textColor = Colors.white
    ..indicatorColor = const Color(0xFF5D9CEC)
    ..userInteractions = false
    ..dismissOnTap = false;
}
