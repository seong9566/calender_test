import 'package:calender_test/features/base/presentation/base_view.dart';
import 'package:calender_test/features/calendar/presentation/view/custom_calendar_view.dart';
import 'package:calender_test/features/auth/presentation/view/login_view.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_detail_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/profile/presentation/profile_view.dart';

// routes.dart
final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/calendar',
  // initialLocation: '/login',
  routes: [
    // 로그인 화면
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginView(),
    ),

    // 로그인 이후 공통 레이아웃
    ShellRoute(
      navigatorKey: shellNavKey,
      builder: (context, state, child) {
        return BaseView(child: child);
      },
      routes: [
        // /calendar → 달력 탭
        GoRoute(
          path: '/calendar',
          name: 'calendar',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: CustomCalendarView()),
        ),
        // /profile → 프로필 탭
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ProfileView()),
          // Profile 내부 하위 페이지가 있다면 아래 routes에 더 작성하면 됌.
          // routes: [],
        ),
      ],
    ),
  ],
);
