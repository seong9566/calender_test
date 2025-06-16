import 'package:calender_test/core/theme/app_theme.dart';
import 'package:calender_test/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/features/business/presentation/providers/business_providers_di.dart';
import 'package:calender_test/features/business/presentation/viewmodels/business_selection_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BusinessSelectionView extends ConsumerStatefulWidget {
  const BusinessSelectionView({super.key});

  @override
  ConsumerState<BusinessSelectionView> createState() =>
      _BusinessSelectionViewState();
}

class _BusinessSelectionViewState extends ConsumerState<BusinessSelectionView> {
  BusinessLocationEntity? _selectedLocation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(businessSelectionViewModelProvider.notifier)
          .getBusinessLocations();
    });
  }

  /// 사업장 선택 처리
  void selectItem(BusinessLocationEntity location) {
    setState(() {
      _selectedLocation = location;
    });
    // ViewModel에 선택한 사업장 정보 전달
    ref
        .read(businessSelectionViewModelProvider.notifier)
        .selectLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(businessSelectionViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text('사업장 선택', style: titleStyle)),
      body: _buildBody(state),
      bottomNavigationBar: _bottomNavigationBar(state),
    );
  }

  Widget _buildBody(BusinessSelectionState state) {
    switch (state.status) {
      case BusinessSelectionStatusEnum.initial:
      case BusinessSelectionStatusEnum.loading:
        return const Center(child: CircularProgressIndicator());
      case BusinessSelectionStatusEnum.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage ?? '오류가 발생했습니다',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(businessSelectionViewModelProvider.notifier)
                      .getBusinessLocations();
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        );
      case BusinessSelectionStatusEnum.success:
        return state.locations.isEmpty
            ? const Center(child: Text('사업장 목록이 없습니다'))
            : _listViewWidget(state.locations);
    }
  }

  Widget _bottomNavigationBar(BusinessSelectionState state) {
    final bool isButtonEnabled = state.selectedLocation != null;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultHPadding),
        child: ElevatedButton(
          onPressed: isButtonEnabled
              ? () async {
                  // 로딩 표시를 위한 다이얼로그 표시
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    // 비동기로 사업장 추가 요청
                    await ref
                        .read(businessSelectionViewModelProvider.notifier)
                        .addBusinessLocation(LoginStatusEnum.manager);

                    // 현재 상태 확인
                    final currentState = ref.read(
                      businessSelectionViewModelProvider,
                    );

                    // 로딩 다이얼로그 닫기
                    if (context.mounted) Navigator.of(context).pop();

                    // 성공 시에만 화면 이동
                    if (currentState.status ==
                        BusinessSelectionStatusEnum.success) {
                      if (context.mounted) context.goNamed('calendar');
                    } else {
                      // 실패 시 스낵바 표시
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              currentState.errorMessage ?? '권한 추가에 실패했습니다',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    // 예외 발생 시 로딩 다이얼로그 닫기 및 스낵바 표시
                    if (context.mounted) Navigator.of(context).pop();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('오류가 발생했습니다: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              : null,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
            backgroundColor: WidgetStatePropertyAll(
              isButtonEnabled ? primaryColor : Colors.grey.shade300,
            ),
          ),
          child: Text(
            '확인',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: isButtonEnabled ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  /// 사업장 목록 위젯 생성
  Widget _listViewWidget(List<BusinessLocationEntity> locations) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultHPadding),
      child: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          final isSelected =
              _selectedLocation?.locationId == location.locationId;

          return selectCardItem(
            location.locationName,
            location.contractNum,
            isSelected,
            () {
              selectItem(location);
            },
          );
        },
      ),
    );
  }

  Widget selectCardItem(
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      color: isSelected ? Colors.white : Colors.black,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Color(0xffF5F5FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textStyle),
            Text(subtitle, style: textStyle),
          ],
        ),
      ),
    );
  }
}
