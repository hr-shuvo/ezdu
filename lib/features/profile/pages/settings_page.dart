import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar will automatically show a close (x) icon
      // because we set fullscreenDialog: true in the MaterialPageRoute.
      appBar: AppBar(
        title: const Text('Settings'),
        // No need to set the leading widget manually!
      ),
      body: const Center(
        child: Text('This is the full-screen Settings Page!'),
      ),
    );
  }
}