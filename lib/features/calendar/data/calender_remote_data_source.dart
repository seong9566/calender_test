// 실제 구현체는 DioClient를 활용하여 API 호출을 담당하게 됩니다.
abstract class CalenderRemoteDataSource {
  Future<void> fetchCalender(int todo);
}
