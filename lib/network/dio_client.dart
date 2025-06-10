import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/network/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  // 로그아웃 콜백 (앱에서 DI 또는 setter로 주입 가능)
  static void Function()? onLogout;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoint.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json', "X-Device-OS": "AOS"},
      ),
    );

    /// 토큰 추가 인터셉터
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageUtil.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) async {
          // 401 Unauthorized 처리: 토큰 만료시 자동 로그아웃 및 토큰 삭제
          if (e.response?.statusCode == 401) {
            await SecureStorageUtil.clearAll();
            if (onLogout != null) onLogout!();
          }
          handler.next(e);
        },
        onResponse: (response, handler) => handler.next(response),
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint("[Debug] dio Post : path : $path");
    debugPrint("[Debug] dio Post : data : $data");
    debugPrint("[Debug] dio Post : header : ${dio.options.baseUrl}");
    debugPrint("[Debug] dio Post : header : ${dio.options.headers}");
    return await dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
