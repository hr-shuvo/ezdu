import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String name;

  const OptionModel({required this.name});

  factory OptionModel.toModel(Map<String, dynamic> json) {
    return OptionModel(name: json['name']);
  }

  @override
  List<Object?> get props => [];
}
