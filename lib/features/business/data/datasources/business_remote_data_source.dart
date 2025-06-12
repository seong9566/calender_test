import 'package:calender_test/features/business/data/models/business_location_model.dart';
import 'package:calender_test/network/api_endpoint.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:dio/dio.dart';

abstract class BusinessRemoteDataSource {
  Future<BaseResponse<List<BusinessLocationModel>>> getBusinessLocations();
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final DioClient _dioClient;

  BusinessRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseResponse<List<BusinessLocationModel>>> getBusinessLocations() async {
    try {
      final response = await _dioClient.get(
        ApiEndPoint.businessLocations,
      );
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return BaseResponse.fromJson(
        responseData,
        (json) => (json as List)
            .map((item) => BusinessLocationModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      final Map<String, dynamic> errorResponseData =
          e.response!.data as Map<String, dynamic>;
      try {
        return BaseResponse<List<BusinessLocationModel>>.fromJson(
          errorResponseData,
          (json) => (json as List)
              .map((item) => BusinessLocationModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (parseError) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
