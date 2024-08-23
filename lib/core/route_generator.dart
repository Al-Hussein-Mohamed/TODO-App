import 'package:flutter/material.dart';
import 'package:to_do_app/core/page_route_names.dart';
import 'package:to_do_app/features/login/login_view.dart';
import 'package:to_do_app/features/registrations/registration_view.dart';
import 'package:to_do_app/features/splash/splash_view.dart';

import '../features/layout_view.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );

      case PageRouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );

      case PageRouteNames.registration:
        return MaterialPageRoute(
          builder: (context) => const RegistrationView(),
          settings: settings,
        );

      case PageRouteNames.layout:
        return MaterialPageRoute(
          builder: (context) =>  const LayoutView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
    }
  }
}
