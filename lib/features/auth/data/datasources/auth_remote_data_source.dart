import 'package:calender_test/features/auth/data/models/login_response_model.dart';
import 'package:calender_test/network/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<LoginResponseModel>> login(
    String userId,
    String userPassword,
    String fcmToken,
  );
}
