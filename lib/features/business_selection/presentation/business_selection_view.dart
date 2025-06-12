import 'package:calender_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BusinessModel {
  final String title;
  final String subtitle;
  bool isSelected;

  BusinessModel({
    required this.title,
    required this.subtitle,
    required this.isSelected,
  });
}

final businessDumyList = [
  BusinessModel(title: '강남 우체국', subtitle: 'A1B2C3', isSelected: false),
  BusinessModel(title: 'B사업장', subtitle: 'A34D56', isSelected: false),
  BusinessModel(title: 'C사업장', subtitle: 'A34D56', isSelected: false),
];

class BusinessSelectionView extends ConsumerStatefulWidget {
  const BusinessSelectionView({super.key});

  @override
  ConsumerState<BusinessSelectionView> createState() =>
      _BusinessSelectionViewState();
}

class _BusinessSelectionViewState extends ConsumerState<BusinessSelectionView> {
  void selectItem(int index) {
    setState(() {
      for (var item in businessDumyList) {
        item.isSelected = false;
      }
      businessDumyList[index].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사업장 선택', style: titleStyle)),
      body: _listViewWidget(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultHPadding),
        child: ElevatedButton(
          onPressed: () {
            print("확인 버튼 클릭");

            /// API 요청 이후 Main페이지로 이동
            context.goNamed('calendar');
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
            backgroundColor: WidgetStatePropertyAll(primaryColor),
          ),
          child: Text(
            '확인',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Padding _listViewWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultHPadding),
      child: ListView.builder(
        itemCount: businessDumyList.length,
        itemBuilder: (context, index) {
          final business = businessDumyList[index];
          return selectCardItem(
            business.title,
            business.subtitle,
            business.isSelected,
            () {
              selectItem(index);
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
