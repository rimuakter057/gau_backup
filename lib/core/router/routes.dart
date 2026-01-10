import 'package:flutter/cupertino.dart';
import 'package:gau_app/features/auth/grade/presentation/screens/grade_screen.dart';
import 'package:gau_app/features/auth/presentation/screens/login_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_inbox_screen.dart';
import 'package:gau_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:gau_app/features/common/splash/splash_screen.dart';
import 'package:gau_app/features/home/presentation/screens/home_screen.dart';
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
      // GoRoute(
      //   name: RoutePath.selectedScreen,
      //   path: RoutePath.selectedScreen.addBasePath,
      //   pageBuilder: (context, state) {
      //     return _buildPageWithAnimation(
      //       child:  SelectedScreen(),
      //       state: state,
      //     );
      //   },
      // ),

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



//       GoRoute(
//         name: RoutePath.signUpScreen,
//         path: RoutePath.signUpScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  SignUpScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//       GoRoute(
//         name: RoutePath.forgotPassScreen,
//         path: RoutePath.forgotPassScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  ForgotPasswordScreen(),
//             state: state,
//           );
//         },
//       ),
//
//       GoRoute(
//         name: RoutePath.verifyCodeScreen,
//         path: RoutePath.verifyCodeScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  VerifyCodeScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//       GoRoute(
//         name: RoutePath.verifyEmailScreen,
//         path: RoutePath.verifyEmailScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  VerifyEmailScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//
//
//       ///======================= User Bottom Navbar user =======================
//       ShellRoute(
//         builder: (context, state, child) {
//           return MainNavBar(child: child); // 👈 Navbar wrapper
//         },
//         routes: [
//
//           ///home route=========================================================
//           GoRoute(
//             name: RoutePath.homeScreen,
//             path: RoutePath.homeScreen.addBasePath,
//             pageBuilder: (context, state) {
//               return _buildPageWithAnimation(
//                 child:  HomeScreen(),
//                 state: state,
//               );
//             },
//           ),
//
//           ///======================= cart Route =======================
//           GoRoute(
//             name: RoutePath.cartScreen,
//             path: RoutePath.cartScreen.addBasePath,
//             pageBuilder: (context, state) {
//               return _buildPageWithAnimation(
//                 child:  CartScreen(),
//                 state: state,
//               );
//             },
//           ),
//           ///product route=========================================================
//           GoRoute(
//             name: RoutePath.productScreen,
//             path: RoutePath.productScreen.addBasePath,
//             pageBuilder: (context, state) {
//               return _buildPageWithAnimation(
//                 child:  ProductScreen(),
//                 state: state,
//               );
//             },
//           ),
//
//
//           ///chat route=========================================================
//
//
//           ///order route=========================================================
//
//           GoRoute(
//             name: RoutePath.orderScreen,
//             path: RoutePath.orderScreen.addBasePath,
//             pageBuilder: (context, state) {
//               return _buildPageWithAnimation(
//                 child:  OrderScreen(),
//                 state: state,
//               );
//             },
//           ),
//
//         ],
//       ),
//
//
//
//
//
//
//
// ///===========================other screens=============================
//
//
//
//
//
// ///cart================================
//
//       GoRoute(
//         name: RoutePath.paymentScreen,
//         path: RoutePath.paymentScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  PaymentScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//
//       GoRoute(
//         name: RoutePath.cartDetailsScreen,
//         path: RoutePath.cartDetailsScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  CartDetailsScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//
//       ///======================= profile Route =======================
//
//       GoRoute(
//         name: RoutePath.profileScreen,
//         path: RoutePath.profileScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  ProfileScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//
//
//
//       GoRoute(
//         name: RoutePath.editProfileScreen,
//         path: RoutePath.editProfileScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  EditProfileScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//       ///product route=========================================================
//       GoRoute(
//         name: RoutePath.productDetailsScreen,
//         path: RoutePath.productDetailsScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  ProductDetailsScreen(),
//             state: state,
//           );
//         },
//       ),
//
//       GoRoute(
//         name: RoutePath.exclusiveProductScreen,
//         path: RoutePath.exclusiveProductScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  ExclusiveProductScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//       GoRoute(
//         name: RoutePath.featureProductScreen,
//         path: RoutePath.featureProductScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  FeatureProductScreen(),
//             state: state,
//           );
//         },
//       ),
//
//
//
//
//
//
//       ///doc===================================
//
//       GoRoute(
//         name: RoutePath.termsOfConditionScreen,
//         path: RoutePath.termsOfConditionScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  TermsConditionScreen(),
//             state: state,
//           );
//         },
//       ),
//
//       GoRoute(
//         name: RoutePath.privacyPolicyScreen,
//         path: RoutePath.privacyPolicyScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  PrivacyPolicyScreen(),
//             state: state,
//           );
//         },
//       ),
//       ///notification=============================================================
//       GoRoute(
//         name: RoutePath.notificationScreen,
//         path: RoutePath.notificationScreen.addBasePath,
//         pageBuilder: (context, state) {
//           return _buildPageWithAnimation(
//             child:  NotificationScreen(),
//             state: state,
//           );
//         },
//       ),




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
