// Implementation of AuthRemoteDataSource
import 'package:calender_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:calender_test/features/auth/data/models/login_response_model.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:calender_test/network/api_endpoint.dart';
import 'package:calender_test/network/api_error.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(
    String userId,
    String userPassword,
    String fcmToken,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndPoint.login,
        data: {
          'loginId': userId,
          'loginPassword': userPassword,
          // 'fcmToken': fcmToken,
        },
      );
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      return BaseResponse.fromJson(
        responseData,
        (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      // 네트워크 에러 처리 중 발생한 예외 처리
      return ApiError.handleDioException<LoginResponseModel>(
        e,
        (json) => LoginResponseModel.fromJson(json),
        LoginResponseModel.empty(),
      );
    } catch (e) {
      // 그 외 일반적인 예외 처리
      return ApiError.handleGeneralException<LoginResponseModel>(
        e,
        LoginResponseModel.empty(),
      );
    }
  }
}
