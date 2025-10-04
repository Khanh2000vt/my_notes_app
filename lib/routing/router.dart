// Cấu hình GoRouter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/expense/expense_screen.dart';
import 'package:my_notes_app/features/expense/model/expense_model.dart';
import 'package:my_notes_app/features/login/login_screen.dart';
import 'package:my_notes_app/features/room/room_screen.dart';
import 'package:my_notes_app/features/summary/summary_screen.dart';
import 'package:my_notes_app/routing/routes.dart';

final ValueNotifier<String?> authToken = ValueNotifier(null);

final router = GoRouter(
  refreshListenable: authToken,
  initialLocation: Routes.login,
  redirect: (context, state) {
    final String? token = authToken.value;
    final bool isLoggedIn = token != null && token.isNotEmpty;
    final bool isLoginPage = state.matchedLocation == Routes.login;
    // Nếu URL không xác định (không khớp với route nào), chuyển hướng đến login
    if (state.matchedLocation.isEmpty || state.error != null) {
      return Routes.login;
    }
    // Nếu chưa đăng nhập và không ở trang login, chuyển hướng đến login
    if (!isLoggedIn && !isLoginPage) {
      return Routes.login;
    }
    // Nếu đã đăng nhập và ở trang login, chuyển hướng đến home
    if (isLoggedIn && isLoginPage) {
      return Routes.room;
    }
    return null; // Không cần chuyển hướng
  },
  routes: [
    GoRoute(
      path: Routes.room,
      builder: (context, state) {
        return RoomScreen();
      },
    ),
    GoRoute(
      path: Routes.expense,
      builder: (context, state) {
        final model = state.extra as ExpenseModel;
        return ExpenseScreen(model: model);
      },
    ),
    GoRoute(
      path: Routes.summaryExpense,
      builder: (context, state) {
        return SummaryScreen();
      },
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => const RoomScreen(),
);
