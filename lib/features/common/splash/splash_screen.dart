import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gau_app/core/enum/role.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/core/service/datasource/local/local_service.dart';
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

    context.go(RoutesPath.loginScreen.addBasePath);
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
