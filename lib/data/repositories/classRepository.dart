import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/data/datasources/class_remote_ds.dart';

class ClassRepository {
  final ClassRemoteDataSource _remoteDataSource;

  ClassRepository({required ClassRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<ClassModel>>> getOnboardingClassList(
    int segment,
  ) async {
    try {
      final result = await _remoteDataSource.getOnboardingClassList(segment);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
