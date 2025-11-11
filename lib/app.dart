import 'package:ezdu/app/routes/app_routes.dart';
import 'package:ezdu/app/theme/app_themes.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [authInitProvider, onboardingInitProvider],
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(authInitProvider);
          ref.watch(onboardingInitProvider);

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green[50]!, Colors.blue[50]!],
              ),
            ),
            child: MaterialApp(
              title: 'ezdu',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: '/',
            ),
          );
        },
      ),
    );
  }
}
