import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final int id;
  final String name;
  final int subjectId;

  const Lesson({required this.id, required this.name, required this.subjectId});

  @override
  List<Object?> get props => [];
}
