import 'package:calender_test/features/auth/data/models/login_response_data.dart';
import 'package:calender_test/network/base_response.dart';

// Abstract class defining the contract for the authentication repository
abstract class AuthRepository {
  Future<BaseResponse<LoginResponseData>> login(
    String userId,
    String userPassword,
    String fcmToken,
    String uuid,
  );
}
