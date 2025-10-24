import 'package:ezdu/data/models/api_response.dart';
import 'package:ezdu/features/auth/datasources/auth_remote_ds.dart';
import 'package:ezdu/features/auth/models/auth_model.dart';
import 'package:ezdu/services/dio_client.dart';
import 'package:ezdu/services/storage_service.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;
  final DioClient _dioClient;

  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required StorageService storageService,
    required DioClient dioClient,
  }) : _remoteDataSource = remoteDataSource,
       _storageService = storageService,
       _dioClient = dioClient;

  Future<ApiResponse<AuthModel>> login(String email, String password) async {
    try {
      final auth = await _remoteDataSource.login(email, password);

      await _storageService.saveToken(auth.token);
      _dioClient.setAuthToken(auth.token);

      return ApiResponse.success(auth);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<void> logout() async {
    await _storageService.clearAll();
    _dioClient.clearAuthToken();
  }
}
