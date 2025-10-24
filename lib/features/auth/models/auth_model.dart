import 'package:equatable/equatable.dart';
import 'package:ezdu/features/auth/models/auth_user_model.dart';

class AuthModel extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String token;

  // final AuthUserModel user;

  const AuthModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.token,
  });

  factory AuthModel.toModel(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userName: json['username'] ?? '',
      token: json['token'] ?? '',

      // user: AuthUserModel.toModel(json['user']),
    );
  }

  @override
  List<Object?> get props => [token, name, userName, id];
}
