import 'package:calender_test/features/auth/data/models/login_response_model.dart';
import 'package:calender_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'dart:async';

/// 로그인 결과 타입 정의
enum LoginResultType {
  /// 관리자 로그인 성공 (코드 100)
  manager,

  /// 일반 사용자 로그인 성공 (코드 200)
  user,

  /// 비밀번호 변경 필요 (코드 201)
  changePassword,

  /// 로그인 실패 (기타 코드)
  error,
}

/// 로그인 결과 클래스
class LoginResult {
  final LoginResultType type;
  final String? accessToken;
  final String? refreshToken;
  final String? rule;
  final String? errorMessage;
  final int? code;

  LoginResult.success({
    required this.type,
    required this.accessToken,
    required this.refreshToken,
    required this.rule,
    this.code,
  }) : errorMessage = null;

  LoginResult.changePassword({required this.code})
    : type = LoginResultType.changePassword,
      accessToken = null,
      refreshToken = null,
      rule = null,
      errorMessage = null;

  LoginResult.error({required this.errorMessage, this.code})
    : type = LoginResultType.error,
      accessToken = null,
      refreshToken = null,
      rule = null;
}

/// 로그인 유스케이스
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  /// 로그인 시도 및 결과 처리
  ///
  /// [userId] 사용자 아이디
  /// [userPassword] 사용자 비밀번호
  /// [fcmToken] Firebase 클라우드 메시징 토큰
  /// [uuid] 기기 고유 식별자
  ///
  /// 반환값: [LoginResult] 로그인 결과 정보
  Future<LoginResult> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  ) async {
    try {
      // 1. 비즈니스 규칙 검증
      _validateLoginInputs(userId, userPassword);

      // 2. 데이터 정규화
      final normalizedUserId = _normalizeUserId(userId);

      // 3. API 호출
      final response = await _repository.login(
        normalizedUserId,
        userPassword,
        fcmToken,
        uuid,
      );

      // 4. 응답 처리 및 결과 반환
      return _processLoginResponse(response);
    } on ArgumentError catch (e) {
      // 입력값 검증 오류
      return LoginResult.error(errorMessage: e.message);
    } catch (e) {
      // 기타 오류
      return LoginResult.error(
        errorMessage: '로그인 중 오류가 발생했습니다: ${e.toString()}',
      );
    }
  }

  /// 로그인 입력값 검증
  void _validateLoginInputs(String userId, String userPassword) {
    if (userId.isEmpty) {
      throw ArgumentError('아이디를 입력해주세요.');
    }

    if (userPassword.isEmpty) {
      throw ArgumentError('비밀번호를 입력해주세요.');
    }

    // 추가 검증 규칙은 여기에 구현
  }

  /// 사용자 ID 정규화 (소문자 변환, 공백 제거 등)
  String _normalizeUserId(String userId) {
    return userId.trim();
  }

  /// 로그인 응답 처리 및 결과 변환
  LoginResult _processLoginResponse(BaseResponse<LoginResponseModel> response) {
    switch (response.code) {
      case 100:
        // 관리자 로그인 성공
        final rule = _extractRuleFromMessage(response.message);
        return LoginResult.success(
          type: LoginResultType.manager,
          accessToken: response.data.accessToken,
          refreshToken: response.data.refreshToken,
          rule: rule,
          code: response.code,
        );

      case 200:
        // 일반 사용자 로그인 성공
        final rule = _extractRuleFromMessage(response.message);
        return LoginResult.success(
          type: LoginResultType.user,
          accessToken: response.data.accessToken,
          refreshToken: response.data.refreshToken,
          rule: rule,
          code: response.code,
        );

      case 201:
        // 비밀번호 변경 필요
        return LoginResult.changePassword(code: response.code);

      default:
        // 로그인 실패
        return LoginResult.error(
          errorMessage: response.message,
          code: response.code,
        );
    }
  }

  /// 메시지에서 권한 정보 추출
  String _extractRuleFromMessage(String message) {
    final RegExp regExp = RegExp(r'\(([^)]+)\)');
    final match = regExp.firstMatch(message);
    return match?.group(1) ?? '';
  }

  /// 토큰 저장 처리
  Future<void> saveTokens(
    String accessToken,
    String refreshToken,
    String rule,
  ) async {
    await SecureStorageUtil.saveAccessToken(accessToken);
    await SecureStorageUtil.saveRefreshToken(refreshToken);
    await SecureStorageUtil.saveRule(rule);
  }
}
