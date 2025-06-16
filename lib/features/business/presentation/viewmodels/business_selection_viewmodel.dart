import 'package:calender_test/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/features/business/domain/entities/business_result.dart';
import 'package:calender_test/features/business/domain/usecases/add_business_location_usecase.dart';
import 'package:calender_test/features/business/domain/usecases/get_business_locations_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 비즈니스 선택 화면의 상태
enum BusinessSelectionStatusEnum { initial, loading, success, error }

/// 비즈니스 선택 화면의 상태 클래스
class BusinessSelectionState {
  /// 현재 상태
  final BusinessSelectionStatusEnum status;

  /// 사업장 목록
  final List<BusinessLocationEntity> locations;

  /// 선택된 사업장
  final BusinessLocationEntity? selectedLocation;

  /// 오류 메시지
  final String? errorMessage;

  const BusinessSelectionState({
    required this.status,
    required this.locations,
    this.selectedLocation,
    this.errorMessage,
  });

  /// 초기 상태 생성 팩토리 메서드
  factory BusinessSelectionState.initial() => const BusinessSelectionState(
    status: BusinessSelectionStatusEnum.initial,
    locations: [],
  );

  /// 상태 복사 메서드
  BusinessSelectionState copyWith({
    BusinessSelectionStatusEnum? status,
    List<BusinessLocationEntity>? locations,
    BusinessLocationEntity? selectedLocation,
    String? errorMessage,
    bool clearSelectedLocation = false,
    bool clearErrorMessage = false,
  }) {
    return BusinessSelectionState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      selectedLocation: clearSelectedLocation
          ? null
          : (selectedLocation ?? this.selectedLocation),
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}

/// 사업장 선택 화면의 ViewModel
class BusinessSelectionViewModel extends StateNotifier<BusinessSelectionState> {
  final GetBusinessLocationsUseCase _getBusinessLocationsUseCase;
  final AddBusinessLocationUseCase _addBusinessLocationUseCase;

  BusinessSelectionViewModel(
    this._getBusinessLocationsUseCase,
    this._addBusinessLocationUseCase,
  ) : super(BusinessSelectionState.initial());

  /// 사업장 목록 조회
  Future<void> getBusinessLocations() async {
    // 로딩 상태로 변경
    state = state.copyWith(status: BusinessSelectionStatusEnum.loading);

    try {
      // UseCase 실행 - BusinessLocationsResult 반환
      final result = await _getBusinessLocationsUseCase.execute();

      if (result.type == BusinessLocationsResultType.success) {
        // 성공: 위치 목록과 권한 정보 업데이트
        state = state.copyWith(
          status: BusinessSelectionStatusEnum.success,
          locations: result.locations ?? [],
          clearErrorMessage: true,
        );
      } else {
        // 실패: 오류 메시지 업데이트
        state = state.copyWith(
          status: BusinessSelectionStatusEnum.error,
          errorMessage: result.message ?? '사업장 목록을 가져오는 중 오류가 발생했습니다',
        );
      }
    } catch (e) {
      // 예외 처리
      state = state.copyWith(
        status: BusinessSelectionStatusEnum.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 사업장 위치 권한 추가
  Future<void> addBusinessLocation(LoginStatusEnum loginStatusEnum) async {
    // 로딩 상태로 변경
    state = state.copyWith(status: BusinessSelectionStatusEnum.loading);

    try {
      // UseCase 실행 - UserPermissionEntity 반환
      if (loginStatusEnum == LoginStatusEnum.user) {
        // 일반 사용자는 locationId 없이 호출
        await _addBusinessLocationUseCase.execute();
      } else {
        // 관리자는 선택한 사업장 ID로 호출
        await _addBusinessLocationUseCase.execute(
          locationId: state.selectedLocation?.locationId,
        );
      }

      state = state.copyWith(
        status: BusinessSelectionStatusEnum.success,
        clearErrorMessage: true,
      );
    } catch (e) {
      // 예외 처리
      state = state.copyWith(
        status: BusinessSelectionStatusEnum.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 사업장 선택
  void selectLocation(BusinessLocationEntity location) {
    state = state.copyWith(selectedLocation: location);
  }
}
