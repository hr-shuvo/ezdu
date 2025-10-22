import 'package:ezdu/features/auth/presentation/pages/login_page.dart';
import 'package:ezdu/features/navigation/presentation/pages/main_navigation_page.dart';
import 'package:ezdu/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/register':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
