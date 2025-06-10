import 'package:calender_test/features/calendar/presentation/view/custom_calendar_view.dart';
import 'package:calender_test/features/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseView extends StatefulWidget {
  final Widget child;
  const BaseView({super.key, required this.child});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  final pages = [CustomCalendarView(), ProfileView()];
  late int currentIndex;
  Color _fabColor = Colors.white;
  final Color _fabHoverColor = Colors.grey.shade200;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  void changeIndex(int index) {
    switch (index) {
      case 0:
        context.goNamed('calendar');
        break;
      case 1:
        context.goNamed('profile');
        break;
      default:
        context.goNamed('calendar');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: widget.child,
      bottomNavigationBar: _bottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _fabButton(),
    );
  }

  MouseRegion _fabButton() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _fabColor = _fabHoverColor;
        });
      },
      onExit: (_) {
        setState(() {
          _fabColor = Colors.white;
        });
      },
      child: FloatingActionButton(
        backgroundColor: _fabColor,
        onPressed: () {
          debugPrint("[Debug] Floating Button!");
        },
        child: const Icon(Icons.add_box_outlined, color: Colors.black),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          debugPrint("[Debug] Menu Icon Click!");
        },
        icon: Icon(Icons.menu, size: 20, weight: 24, color: Colors.black),
      ),
      title: Text(
        "Calendar",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            debugPrint("[Debug] Add Icon Click!");
          },
          icon: Icon(Icons.add, size: 20, weight: 24, color: Colors.black),
        ),
      ],

      centerTitle: true,
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => changeIndex(index),
      currentIndex: currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      // 선택된 라벨은 볼드체로
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12, // 원한다면 글자 크기도 조절
      ),
      // 선택되지 않은 라벨은 일반 두께로
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity),
          label: "Profile",
        ),
      ],
    );
  }
}
