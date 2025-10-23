import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int totalXP;
  final String level;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.totalXP,
    required this.level,
  });

  @override
  List<Object?> get props => [id, name, email, photoUrl, totalXP, level];
}