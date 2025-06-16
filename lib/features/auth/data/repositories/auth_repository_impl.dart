import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:calender_test/features/auth/data/models/login_response_model.dart';
import 'package:calender_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:calender_test/network/base_response.dart';

/// AuthRepository 구현체
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<LoginResponseModel>> login(
    String userId,
    String userPassword,
    String fcmToken,
  ) async {
    // RemoteDataSource에서 로그인 요청 (에러 처리도 RemoteDataSource에서 진행)
    final response = await _remoteDataSource.login(
      userId,
      userPassword,
      fcmToken,
    );
    
    // 로그인 성공 시 SecureStorage에 정보 저장
    if (response.code == 100 || response.code == 200) {
      await SecureStorageUtil.saveLoginInfo(response.data);
      
      // 토큰 정보 저장 메서드 호출
      String rule = '';
      if (response.message.contains('rule:')) {
        rule = response.message.split('rule:')[1].trim();
      }
      
      await saveTokens(
        accessToken: response.data.accessToken,
        refreshToken: response.data.refreshToken,
        rule: rule,
      );
    }
    
    return response;
  }
  
  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String rule,
  }) async {
    try {
      // SecureStorageUtil을 사용하여 토큰 정보 저장
      await SecureStorageUtil.saveAccessToken(accessToken);
      await SecureStorageUtil.saveRefreshToken(refreshToken);
      if (rule.isNotEmpty) {
        await SecureStorageUtil.saveRule(rule);
      }
    } catch (e) {
      throw Exception('토큰 저장 중 오류 발생: $e');
    }
  }
}
