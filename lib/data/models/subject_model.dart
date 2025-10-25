import 'dart:ui';

import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String name;
  final List<Color> gradient;
  final String emoji;
  final int examCount;

  const Subject({
    required this.id,
    required this.name,
    required this.gradient,
    required this.emoji,
    required this.examCount,
  });

  @override
  List<Object?> get props => [];
}
