import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 120, color: colorScheme.primary),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed('/onboarding-flow');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                child: const Text('GET STARTED'),
              ),
              const SizedBox(height: 24),

              // LOGIN Button: Skips Onboarding
              OutlinedButton(
                onPressed: () {
                  // Navigate directly to the login screen
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('I ALREADY HAVE AN ACCOUNT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
