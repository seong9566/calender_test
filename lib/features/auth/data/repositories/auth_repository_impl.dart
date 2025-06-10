import 'package:calender_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:calender_test/features/auth/data/models/login_response_data.dart';
import 'package:calender_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:dio/dio.dart';

// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<LoginResponseData>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  ) async {
    try {
      final response = await _remoteDataSource.login(
        userId,
        userPassword,
        fcmToken,
        uuid,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data['response'] != null) {
        try {
          final Map<String, dynamic> errorResponseData =
              e.response!.data['response'] as Map<String, dynamic>;
          return BaseResponse<LoginResponseData>.fromJson(
            errorResponseData,
            (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
          );
        } catch (parseError) {
          throw Exception('Failed to parse error response: $parseError');
        }
      }
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
