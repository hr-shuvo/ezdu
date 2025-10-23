import 'package:ezdu/features/auth/presentation/pages/login_page.dart';
import 'package:ezdu/features/auth/presentation/pages/register_page.dart';
import 'package:ezdu/features/navigation/presentation/pages/main_navigation_page.dart';
import 'package:ezdu/features/profile/presentation/pages/profile_page.dart';
import 'package:ezdu/features/quiz/presentation/pages/quiz_page.dart';
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
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());

      case '/quiz':
        return MaterialPageRoute(builder: (_) => const QuizPage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
