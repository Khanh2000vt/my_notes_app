// Cấu hình GoRouter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/room/add_expense/add_expense_screen.dart';
import 'package:my_notes_app/features/room/create_room/widget/create_room_screen.dart';
import 'package:my_notes_app/features/home/widgets/home_screen.dart';
import 'package:my_notes_app/features/room/room/room_screen.dart';
import 'package:my_notes_app/features/room/summary_expense/summary_expense_screen.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/routing/routes.dart';

import '../features/auth/login/login_screen.dart';

final ValueNotifier<String?> authToken = ValueNotifier(null);

final router = GoRouter(
  refreshListenable: authToken,
  initialLocation: Routes.summaryExpense,
  redirect: (context, state) {
    return null;
    // final String? token = authToken.value;
    // final bool isLoggedIn = token != null && token.isNotEmpty;
    // final bool isLoginPage = state.matchedLocation == Routes.login;
    // // Nếu URL không xác định (không khớp với route nào), chuyển hướng đến login
    // if (state.matchedLocation.isEmpty || state.error != null) {
    //   return Routes.login;
    // }
    // // Nếu chưa đăng nhập và không ở trang login, chuyển hướng đến login
    // if (!isLoggedIn && !isLoginPage) {
    //   return Routes.login;
    // }
    // // Nếu đã đăng nhập và ở trang login, chuyển hướng đến home
    // if (isLoggedIn && isLoginPage) {
    //   return Routes.home;
    // }
    // return null; // Không cần chuyển hướng
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: Routes.room,
      builder: (context, state) {
        return RoomScreen();
      },
    ),
    GoRoute(
      path: Routes.createRoom,
      builder: (context, state) {
        return CreateRoomScreen();
      },
    ),
    GoRoute(
      path: Routes.addExpense,
      builder: (context, state) {
        final members = state.extra as List<Member>? ?? [];
        return AddExpenseScreen(members: members);
      },
    ),
    GoRoute(
      path: Routes.summaryExpense,
      builder: (context, state) {
        return SummaryExpenseScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => const LoginScreen(),
);
