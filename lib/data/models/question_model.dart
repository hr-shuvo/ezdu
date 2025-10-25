import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int id;
  final String name;

  const Question({required this.id, required this.name});

  @override
  List<Object?> get props => [];
}


