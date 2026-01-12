
import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/presentation/screens/login_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_inbox_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:gau_app/features/common/splash/splash_screen.dart';
import 'package:gau_app/features/grade/presentation/screens/grade_screen.dart';
import 'package:gau_app/features/home/presentation/screens/add_complain_screen.dart';
import 'package:gau_app/features/home/presentation/screens/complain_screen.dart';
import 'package:gau_app/features/home/presentation/screens/home_screen.dart';
import 'package:gau_app/features/home/presentation/screens/transcript_screen.dart';
import 'package:gau_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:gau_app/core/router/route_path.dart';

import 'package:gau_app/utils/extension/base_extension.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= Initial Route =======================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.transcriptScreen,
        path: RoutePath.transcriptScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  TranscriptScreen(),
            state: state,
          );
        },
      ),

      ///======================= auth Route =======================
      GoRoute(
        name: RoutePath.loginScreen,
        path: RoutePath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  LoginScreen(),
            state: state,
          );
        },
      ),
          ///home===========================================

          GoRoute(
            name: RoutePath.homeScreen,
            path: RoutePath.homeScreen.addBasePath,
            pageBuilder: (context, state) {
              return _buildPageWithAnimation(
                child:  HomeScreen(),
                state: state,
              );
            },
          ),

      GoRoute(
        name: RoutePath.complainScreen,
        path: RoutePath.complainScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ComplainScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.addComplainScreen,
        path: RoutePath.addComplainScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  AddComplainScreen(),
            state: state,
          );
        },
      ),

      ///grade===========================================

      GoRoute(
        name: RoutePath.gradeScreen,
        path: RoutePath.gradeScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  GradeScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutePath.chatScreen,
        path: RoutePath.chatScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ChatScreen(),
            state: state,
          );
        },
      ),

      ///chat route=========================================================

      GoRoute(
        name: RoutePath.chatInboxScreen,
        path: RoutePath.chatInboxScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ChatInboxScreen(),
            state: state,
          );
        },
      ),

      ///profile route=========================================================

      GoRoute(
        name: RoutePath.profileScreen,
        path: RoutePath.profileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ProfileScreen(),
            state: state,
          );
        },
      ),







    ],
  );







  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}
