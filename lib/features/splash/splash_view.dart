import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/page_route_names.dart';
import 'package:to_do_app/core/setting_provider.dart';

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
      Navigator.pushReplacementNamed(
          context,
          FirebaseAuth.instance.currentUser == null
              ? PageRouteNames.login
              : PageRouteNames.layout);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);

    return Container(
      color: provider.isDark() ? const Color(0xFF060E1E) : const Color(0xFFDFECDB),
      child: Image.asset("assets/icons/splash_logo.png", scale: 3,),
    );
  }
}
