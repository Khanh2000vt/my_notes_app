// Cấu hình GoRouter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/tabs/home/home_screen.dart';
import 'package:my_notes_app/routing/routes.dart';

import '../features/auth/login/login_screen.dart';

final ValueNotifier<String?> authToken = ValueNotifier(null);

final router = GoRouter(
  refreshListenable: authToken,
  redirect: (context, state) {
    return Routes.home;
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
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            return HomeScreen();
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const LoginScreen(),
);
