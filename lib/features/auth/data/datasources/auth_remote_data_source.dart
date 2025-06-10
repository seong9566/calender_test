import 'package:calender_test/features/auth/data/models/login_response_data.dart';
import 'package:calender_test/network/api_endpoint.dart'; // Assuming login endpoint is here
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Abstract class defining the contract for authentication remote data source
abstract class AuthRemoteDataSource {
  Future<BaseResponse<LoginResponseData>> login(
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
  Future<BaseResponse<LoginResponseData>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndPoint.login,
        data: {
          'userId': userId,
          'userPassword': userPassword,
          'fcmToken': fcmToken,
          'uuid': uuid,
        },
      );
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return BaseResponse.fromJson(
        responseData,
        (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      print("e: $e");
      final Map<String, dynamic> errorResponseData =
          e.response!.data as Map<String, dynamic>;
      try {
        return BaseResponse<LoginResponseData>.fromJson(
          errorResponseData,
          (json) => LoginResponseData.fromJson(json as Map<String, dynamic>),
        );
      } catch (parseError) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
