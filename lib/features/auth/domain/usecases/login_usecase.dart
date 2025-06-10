import 'package:calender_test/features/auth/data/models/login_response_data.dart';
import 'package:calender_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:calender_test/network/base_response.dart';

// Use case for user login
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<BaseResponse<LoginResponseData>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  ) async {
    if (userId.isEmpty || userPassword.isEmpty) {
      throw ArgumentError('User ID and password cannot be empty.');
    }
    return await _repository.login(userId, userPassword, fcmToken, uuid);
  }
}
