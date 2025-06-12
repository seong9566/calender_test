import 'package:calender_test/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// DioClient Provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});
