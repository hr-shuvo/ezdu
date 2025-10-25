import 'package:ezdu/app/di/injector.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  await initializeDependencies();

  runApp(const MyApp());
}
