// Cấu hình GoRouter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/tabs/home/home_screen.dart';

import '../core/constants/routers_constants.dart';
import '../features/auth/login/login_screen.dart';

final ValueNotifier<String?> authToken = ValueNotifier(null);

final routers = GoRouter(
  refreshListenable: authToken,
  redirect: (context, state) {
    final String? token = authToken.value;
    final bool isLoggedIn = token != null && token.isNotEmpty;
    final bool isLoginPage = state.matchedLocation == RoutersConstants.login;
    // Nếu URL không xác định (không khớp với route nào), chuyển hướng đến login
    if (state.matchedLocation.isEmpty || state.error != null) {
      return RoutersConstants.login;
    }
    // Nếu chưa đăng nhập và không ở trang login, chuyển hướng đến login
    if (!isLoggedIn && !isLoginPage) {
      return RoutersConstants.login;
    }
    // Nếu đã đăng nhập và ở trang login, chuyển hướng đến home
    if (isLoggedIn && isLoginPage) {
      return RoutersConstants.home;
    }
    return null; // Không cần chuyển hướng
  },
  routes: [
    GoRoute(
      path: RoutersConstants.login,
      builder: (context, state) {
        return LoginScreen();
      },
    ),
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          path: RoutersConstants.home,
          builder: (context, state) {
            return HomeScreen();
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const LoginScreen(),
);
