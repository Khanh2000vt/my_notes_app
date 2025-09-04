// Cấu hình GoRouter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/create_room/widget/create_room_screen.dart';
import 'package:my_notes_app/features/home/widgets/home_screen.dart';
import 'package:my_notes_app/routing/routes.dart';

import '../features/auth/login/login_screen.dart';

final ValueNotifier<String?> authToken = ValueNotifier(null);

final router = GoRouter(
  refreshListenable: authToken,
  initialLocation: Routes.createRoom,
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
      path: Routes.createRoom,
      builder: (context, state) {
        return CreateRoomScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => const LoginScreen(),
);
