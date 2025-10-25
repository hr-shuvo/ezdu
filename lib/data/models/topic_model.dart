import 'package:equatable/equatable.dart';

class Topic extends Equatable{
  final int id;
  final String name;
  final int lessonId;

  const Topic({required this.id, required this.name, required this.lessonId});

  @override
  List<Object?> get props => [];
}