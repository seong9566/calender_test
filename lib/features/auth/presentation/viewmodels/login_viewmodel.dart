import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginStatusEnum { initial, loading, manager, user, changePwd, error }

class LoginStatus {
  final LoginStatusEnum loginStatus;
  final String? errorMessage;

  const LoginStatus({required this.loginStatus, this.errorMessage});
  factory LoginStatus.initial() =>
      LoginStatus(loginStatus: LoginStatusEnum.initial);

  LoginStatus copyWith({LoginStatusEnum? status, String? errorMessage}) {
    return LoginStatus(
      loginStatus: status ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'LoginStatus(status: $loginStatus)';
  }
}

/// 로그인 화면의 ViewModel
class LoginViewModel extends StateNotifier<LoginStatus> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginStatus.initial());

  bool validateUserId(String userId) {
    final bool isValid = userId.isNotEmpty;

    if (!isValid) {
      return false;
    }

    return true;
  }

  bool validatePassword(String password) {
    final bool isValid = password.isNotEmpty;
    if (!isValid) {
      return false;
    }
    return true;
  }

  /// 로그인
  Future<void> login(String userId, String userPassword) async {
    // 1. 로딩 상태로 변경
    state = state.copyWith(status: LoginStatusEnum.loading);

    try {
      // 2. 필요한 토큰 및 정보 가져오기
      final fcmToken = await SecureStorageUtil.getFcmToken();
      final uuid = await SecureStorageUtil.getUuid();
      if (fcmToken == null || uuid == null) {
        _handleError('기기 정보를 가져올 수 없습니다');
        return;
      }

      // 3. 로그인 API 호출 및 결과 처리
      final result = await _loginUseCase.login(
        userId,
        userPassword,
        fcmToken,
        uuid,
      );

      // 4. 결과에 따른 상태 업데이트
      _handleLoginResult(result);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  /// 로그인 결과 처리
  void _handleLoginResult(LoginResult result) {
    switch (result.type) {
      case LoginResultType.manager:
        // 관리자 로그인 성공
        print("result manager : ${result.type}");
        if (result.accessToken != null &&
            result.refreshToken != null &&
            result.rule != null) {
          print("save Token!: ${result.accessToken}");
          _saveTokens(result.accessToken!, result.refreshToken!, result.rule!);
          state = state.copyWith(status: LoginStatusEnum.manager);
        } else {
          _handleError('토큰 정보가 올바르지 않습니다');
        }
        break;

      case LoginResultType.user:
        // 일반 사용자 로그인 성공
        print("result user : ${result.type}");
        if (result.accessToken != null &&
            result.refreshToken != null &&
            result.rule != null) {
          _saveTokens(result.accessToken!, result.refreshToken!, result.rule!);
          state = state.copyWith(status: LoginStatusEnum.user);
        } else {
          _handleError('토큰 정보가 올바르지 않습니다');
        }
        break;

      case LoginResultType.changePassword:
        // 비밀번호 변경 필요
        print("result changePassword : ${result.type}");
        state = state.copyWith(status: LoginStatusEnum.changePwd);
        break;

      case LoginResultType.error:
        // 로그인 실패
        print("result error : ${result.type}");
        state = state.copyWith(
          status: LoginStatusEnum.error,
          errorMessage: result.errorMessage ?? '알 수 없는 오류가 발생했습니다',
        );
        break;
    }
  }

  /// 오류 처리
  void _handleError(String errorMessage) {
    state = state.copyWith(
      status: LoginStatusEnum.error,
      errorMessage: errorMessage,
    );
  }

  /// 토큰 저장 처리
  Future<void> _saveTokens(
    String accessToken,
    String refreshToken,
    String rule,
  ) async {
    try {
      await _loginUseCase.saveTokens(accessToken, refreshToken, rule);
    } catch (e) {
      _handleError('토큰 저장 중 오류가 발생했습니다: ${e.toString()}');
    }
  }
}
