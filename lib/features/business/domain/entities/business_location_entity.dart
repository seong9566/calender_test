/// 사업장 위치 정보를 나타내는 도메인 엔티티
class BusinessLocationEntity {
  final int locationId;
  final String locationName;
  final String contractNum;
  final DateTime? contractDt;
  // status는 무슨 역할이지
  final bool status;
  final bool isSelected;

  const BusinessLocationEntity({
    required this.locationId,
    required this.locationName,
    required this.contractNum,
    required this.contractDt,
    required this.status,
    this.isSelected = false,
  });

  /// 선택 상태를 변경한 새 인스턴스 생성
  BusinessLocationEntity copyWith({bool? isSelected}) {
    return BusinessLocationEntity(
      locationId: locationId,
      locationName: locationName,
      contractNum: contractNum,
      contractDt: contractDt,
      status: status,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
