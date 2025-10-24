import 'package:ezdu/features/auth/models/auth_model.dart';
import 'package:ezdu/features/auth/models/login_request.dart';
import 'package:ezdu/services/dio_client.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<AuthModel> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);

    var response = await _dioClient.post(
      'auth/login',
      data: request,
      fromJson: (json) {
        return AuthModel.toModel(json);
      },
    );

    return response;
  }
}
