import 'package:calender_test/features/auth/data/models/login_response_model.dart';
import 'package:calender_test/network/api_endpoint.dart'; // Assuming login endpoint is here
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<LoginResponseModel>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  );
}

// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndPoint.login,
        data: {
          'loginId': userId,
          'loginPassword': userPassword,
          'fcmToken': fcmToken,
          'uuid': uuid,
        },
      );
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return BaseResponse.fromJson(
        responseData,
        (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      final Map<String, dynamic> errorResponseData =
          e.response!.data as Map<String, dynamic>;
      try {
        return BaseResponse<LoginResponseModel>.fromJson(
          errorResponseData,
          (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
        );
      } catch (parseError) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
