import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Login State
enum LoginStatus { initial, loading, success, error }

class LoginViewModel extends StateNotifier<LoginStatus> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginStatus.initial);

  Future<void> login(String userId, String userPassword) async {
    state = LoginStatus.loading;
    try {
      final fcmToken = await SecureStorageUtil.getFcmToken();
      final uuid = await SecureStorageUtil.getUuid();

      final response = await _loginUseCase.login(
        userId,
        userPassword,
        fcmToken!,
        uuid!,
      );

      if (response.code == 100) {
        await SecureStorageUtil.saveAccessToken(response.data.accessToken);
        await SecureStorageUtil.saveRefreshToken(response.data.refreshToken);
        final message = response.message;
        final RegExp regExp = RegExp(r'\(([^)]+)\)');
        final match = regExp.firstMatch(message);
        final rule = match?.group(1) ?? '';
        await SecureStorageUtil.saveRule(rule);

        state = LoginStatus.success;
      } else {
        state = LoginStatus.error;
      }
    } on ArgumentError catch (_) {
      // Catch validation errors from UseCase
      state = LoginStatus.error;
    } catch (_) {
      state = LoginStatus.error;
    }
  }
}
