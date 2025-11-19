import 'package:ezdu/data/models/user_model.dart';
import 'package:ezdu/services/dio_client.dart';

class UserRemoteDataSource {
  final DioClient _dioClient;

  UserRemoteDataSource(this._dioClient);

  Future<UserDetailsModel> getUserDetails({
    required int userId,
    int? page,
    int? size,
  }) async {
    var params = {"pageSize": size ?? 50};

    var response = await _dioClient.get(
      'users/details/$userId',
      queryParameters: params,
      fromJson: (json) => UserDetailsModel.toModel(json),
    );

    return response;
  }
}
