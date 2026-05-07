import 'package:flutter/material.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/utils/app_const/app_const.dart';

class CustomProfileAvatar extends StatelessWidget {
  const CustomProfileAvatar({
    super.key, this.height, this.width, this.image,
  });

  final double? height;
  final double? width;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final avatarWidth = width ?? ResponsiveHelper.height(38);
    final avatarHeight = height ?? ResponsiveHelper.width(38);

    return Container(
      width: avatarWidth,
      height: avatarHeight,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(
        image ??AppConstants.unknown,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const ColoredBox(
            color: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          );
        },
      ),
    );
  }
}