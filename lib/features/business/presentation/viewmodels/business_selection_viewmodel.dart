import 'package:calender_test/features/business/data/models/business_location_model.dart';
import 'package:calender_test/features/business/domain/usecases/get_business_locations_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BusinessSelectionStatusEnum { initial, loading, success, error }

class BusinessSelectionState {
  final BusinessSelectionStatusEnum status;
  final List<BusinessLocationModel> locations;
  final String? errorMessage;
  final BusinessLocationModel? selectedLocation;

  const BusinessSelectionState({
    required this.status,
    required this.locations,
    this.errorMessage,
    this.selectedLocation,
  });

  factory BusinessSelectionState.initial() => const BusinessSelectionState(
        status: BusinessSelectionStatusEnum.initial,
        locations: [],
      );

  BusinessSelectionState copyWith({
    BusinessSelectionStatusEnum? status,
    List<BusinessLocationModel>? locations,
    String? errorMessage,
    BusinessLocationModel? selectedLocation,
    bool clearSelectedLocation = false,
    bool clearErrorMessage = false,
  }) {
    return BusinessSelectionState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      selectedLocation: clearSelectedLocation ? null : (selectedLocation ?? this.selectedLocation),
    );
  }
}

/// 사업장 선택 화면의 ViewModel
class BusinessSelectionViewModel extends StateNotifier<BusinessSelectionState> {
  final GetBusinessLocationsUseCase _getBusinessLocationsUseCase;

  BusinessSelectionViewModel(this._getBusinessLocationsUseCase)
      : super(BusinessSelectionState.initial());

  /// 사업장 목록 조회
  Future<void> getBusinessLocations() async {
    // 1. 로딩 상태로 변경
    state = state.copyWith(status: BusinessSelectionStatusEnum.loading);

    try {
      // 2. 사업장 목록 조회 API 호출 및 결과 처리
      final result = await _getBusinessLocationsUseCase.execute();

      // 3. 결과에 따른 상태 업데이트
      _handleResult(result);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  /// 사업장 선택
  void selectLocation(BusinessLocationModel location) {
    state = state.copyWith(selectedLocation: location);
  }

  /// 결과 처리
  void _handleResult(BusinessLocationsResult result) {
    switch (result.type) {
      case BusinessLocationsResultType.success:
        // 성공
        if (result.locations != null) {
          state = state.copyWith(
            status: BusinessSelectionStatusEnum.success,
            locations: result.locations,
            clearErrorMessage: true,
          );
        } else {
          _handleError('사업장 목록이 비어있습니다');
        }
        break;
      case BusinessLocationsResultType.error:
        // 실패
        _handleError(result.errorMessage ?? '알 수 없는 오류가 발생했습니다');
        break;
    }
  }

  /// 오류 처리
  void _handleError(String errorMessage) {
    state = state.copyWith(
      status: BusinessSelectionStatusEnum.error,
      errorMessage: errorMessage,
    );
  }
}
