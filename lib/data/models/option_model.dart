import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String name;

  final bool isCorrect;

  const OptionModel({required this.name, required this.isCorrect});

  factory OptionModel.toModel(Map<String, dynamic> json) {
    return OptionModel(name: json['name'], isCorrect: json['isCorrect']);
  }

  @override
  List<Object?> get props => [];
}
