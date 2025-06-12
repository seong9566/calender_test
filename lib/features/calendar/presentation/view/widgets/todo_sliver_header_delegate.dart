import 'package:flutter/material.dart';

/// 고정 헤더를 위한 위젯 클래스
class TodoSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool isExpanded; // 확장 상태를 나타내는 속성 추가

  TodoSliverHeaderDelegate({
    required this.title,
    this.height = 50.0,
    this.backgroundColor = Colors.white,
    required this.onTap,
    required this.isExpanded, // 생성자에도 추가
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 컨테이너 높이를 명시적으로 지정하여 layoutExtent와 paintExtent가 일치하도록 함
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height, // 명시적으로 높이 지정
        color: backgroundColor,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant TodoSliverHeaderDelegate oldDelegate) =>
      oldDelegate.title != title ||
      oldDelegate.height != height ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.isExpanded != isExpanded;
}
