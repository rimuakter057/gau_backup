
import 'package:flutter/material.dart';
import 'package:gau_app/features/auth/presentation/screens/password_reset_complete_screen.dart';
import 'package:gau_app/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:gau_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:gau_app/features/auth/presentation/screens/login_screen.dart';
import 'package:gau_app/features/auth/presentation/screens/verification_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_inbox_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:gau_app/features/common/splash/splash_screen.dart';
import 'package:gau_app/features/grade/presentation/screens/grade_request_screen.dart';
import 'package:gau_app/features/grade/presentation/screens/grade_screen.dart';
import 'package:gau_app/features/complain/presentation/screens/add_complain_screen.dart';
import 'package:gau_app/features/complain/presentation/screens/complain_screen.dart';
import 'package:gau_app/features/home/presentation/screens/home_screen.dart';
import 'package:gau_app/features/home/presentation/screens/transcript_screen.dart';
import 'package:gau_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:gau_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:gau_app/core/router/route_path.dart';

import 'package:gau_app/utils/extension/base_extension.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutesPath.loginScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= Initial Route =======================
      GoRoute(
        name: RoutesPath.splashScreen,
        path: RoutesPath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutesPath.transcriptScreen,
        path: RoutesPath.transcriptScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  TranscriptScreen(),
            state: state,
          );
        },
      ),

      ///======================= auth Route =======================
      GoRoute(
        name: RoutesPath.loginScreen,
        path: RoutesPath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  LoginScreen(),
            state: state,
          );
        },
      ),



      GoRoute(
        name: RoutesPath.forgotScreen,
        path: RoutesPath.forgotScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ForgotPasswordScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.verificationScreen,
        path: RoutesPath.verificationScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  VerificationScreenScreen(),
            state: state,
          );
        },
      ),



      GoRoute(
        name: RoutesPath.createNewPassScreen,
        path: RoutesPath.createNewPassScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  CreateNewPasswordScreen(),
            state: state,
          );
        },
      ),


      GoRoute(
        name: RoutesPath.passwordResetCompleteScreen,
        path: RoutesPath.passwordResetCompleteScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  PasswordResetCompleteScreen(),
            state: state,
          );
        },
      ),


      ///home===========================================

          GoRoute(
            name: RoutesPath.homeScreen,
            path: RoutesPath.homeScreen.addBasePath,
            pageBuilder: (context, state) {
              return _buildPageWithAnimation(
                child:  HomeScreen(),
                state: state,
              );
            },
          ),

      GoRoute(
        name: RoutesPath.complainScreen,
        path: RoutesPath.complainScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ComplainScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutesPath.addComplainScreen,
        path: RoutesPath.addComplainScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  AddComplainScreen(),
            state: state,
          );
        },
      ),

      ///grade===========================================

      GoRoute(
        name: RoutesPath.gradeScreen,
        path: RoutesPath.gradeScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  GradeScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutesPath.gradeReqScreen,
        path: RoutesPath.gradeReqScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  GradeRequestScreen(),
            state: state,
          );
        },
      ),



      GoRoute(
        name: RoutesPath.chatScreen,
        path: RoutesPath.chatScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ChatScreen(),
            state: state,
          );
        },
      ),

      ///chat route=========================================================

      GoRoute(
        name: RoutesPath.chatInboxScreen,
        path: RoutesPath.chatInboxScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ChatInboxScreen(),
            state: state,
          );
        },
      ),

      ///profile route=========================================================

      GoRoute(
        name: RoutesPath.profileScreen,
        path: RoutesPath.profileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  ProfileScreen(),
            state: state,
          );
        },
      ),



      GoRoute(
        name: RoutesPath.notificationScreen,
        path: RoutesPath.notificationScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child:  NotificationScreen(),
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
