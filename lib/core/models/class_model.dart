import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final int id;
  final String name;
  final List<String> groups;

  const ClassModel({
    required this.id,
    required this.name,
    required this.groups,
  });

  factory ClassModel.toModel(Map<String, dynamic> json) {
    final rawGroups = json['groups'];
    List<String> parsedGroups = [];

    if (rawGroups is String && rawGroups.trim().isNotEmpty) {
      parsedGroups = rawGroups.split(',').map((e) => e.trim()).toList();
    } else if (rawGroups is List) {
      parsedGroups = rawGroups.map((e) => e.toString()).toList();
    }

    return ClassModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      groups: parsedGroups,
    );
  }

  @override
  List<Object?> get props => [];
}
