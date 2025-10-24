import 'package:ezdu/app/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  await initializeDependencies();

  runApp(ProviderScope(child: const MyApp()));
}
