import 'package:flutter/material.dart';
import 'package:gau_app/helper/shared_prefe/shared_prefe.dart';
import 'package:gau_app/utils/app_const/app_const.dart';
import 'package:go_router/go_router.dart';

import 'package:gau_app/core/router/route_path.dart';

import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/extension/base_extension.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }



  Future<void> _handleNavigation() async {

    await Future.delayed(const Duration(seconds: 2));

    String token =
    await SharePrefsHelper.getString(AppConstants.bearerToken);

    print("TOKEN IS============================: $token");

    if (token.isNotEmpty) {

      context.go(RoutesPath.homeScreen.addBasePath);

    } else {

      context.go(RoutesPath.loginScreen.addBasePath);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomImage(imageSrc: AppAssets.appLogoImage),
      ),
    );
  }
}
