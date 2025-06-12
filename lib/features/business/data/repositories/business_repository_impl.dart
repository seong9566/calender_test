import 'package:calender_test/features/business/data/datasources/business_remote_data_source.dart';
import 'package:calender_test/features/business/data/models/business_location_model.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:dio/dio.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<BusinessLocationModel>>> getBusinessLocations() async {
    try {
      final response = await _remoteDataSource.getBusinessLocations();
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data['response'] != null) {
        try {
          final Map<String, dynamic> errorResponseData =
              e.response!.data['response'] as Map<String, dynamic>;
          return BaseResponse<List<BusinessLocationModel>>.fromJson(
            errorResponseData,
            (json) => (json as List)
                .map((item) => BusinessLocationModel.fromJson(item as Map<String, dynamic>))
                .toList(),
          );
        } catch (parseError) {
          throw Exception('Failed to parse error response: $parseError');
        }
      }
      throw Exception('Failed to get business locations: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
