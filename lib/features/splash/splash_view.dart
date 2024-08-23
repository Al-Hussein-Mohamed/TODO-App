import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_app/core/page_route_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, PageRouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splash_background.png",
      fit: BoxFit.cover,
    );
  }
}
