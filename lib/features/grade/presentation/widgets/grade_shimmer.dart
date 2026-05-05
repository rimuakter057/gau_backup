import 'package:flutter/material.dart';
import 'package:gau_app/features/common/widgets/custom_shimmer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/utils/color/app_colors.dart';

class GradeScreenSkeleton extends StatelessWidget {
  const GradeScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return CustomShimmer(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveHelper.height(18)),

              /// GPA CARD
              _GpaCardSkeleton(),

              SizedBox(height: ResponsiveHelper.height(18)),

              /// SEMESTER TABLE
              _SemesterTableSkeleton(),

              SizedBox(height: ResponsiveHelper.height(8)),

              /// NOTICE
              _ShimmerBox(height: ResponsiveHelper.height(80)),
            ],
          ),
        ),
      ),
    );
  }
}

class _GpaCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
      backgroundColor: AppColors.containerGreyBgColor,
      borderColor: AppColors.inputBorderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(height: 16, width: 120),
          SizedBox(height: ResponsiveHelper.height(8)),
          _ShimmerBox(height: 12, width: 200),
          SizedBox(height: ResponsiveHelper.height(16)),

          Row(
            children: [
              Expanded(
                child: _ShimmerBox(height: 60),
              ),
              SizedBox(width: ResponsiveHelper.width(12)),
              Expanded(
                child: _ShimmerBox(height: 60),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _SemesterTableSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColors.white,
      borderColor: AppColors.inputBorderColor,
      child: Column(
        children: [
          SizedBox(height: ResponsiveHelper.height(16)),

          /// DROPDOWN ROW
          Padding(
            padding: ResponsiveHelper.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShimmerBox(height: 14, width: 120),
                _ShimmerBox(height: 32, width: 120),
              ],
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(8)),
          CustomDivider(),

          /// HEADER
          Padding(
            padding: ResponsiveHelper.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShimmerBox(height: 14, width: 80),
                _ShimmerBox(height: 14, width: 100),
              ],
            ),
          ),

          CustomDivider(),

          /// COURSE ROWS
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: ResponsiveHelper.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ShimmerBox(height: 12, width: 80),
                            SizedBox(height: 6),
                            _ShimmerBox(height: 12, width: 140),
                          ],
                        ),
                        _ShimmerBox(height: 12, width: 100),
                      ],
                    ),
                  ),
                  CustomDivider(),
                ],
              );
            },
          ),

          /// GPA FOOTER
          Padding(
            padding: ResponsiveHelper.all(16),
            child: _ShimmerBox(height: 14, width: 140),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double? width;

  const _ShimmerBox({required this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: height,
      width: width ?? double.infinity,
      backgroundColor: AppColors.containerGreyBgColor,
      borderColor: AppColors.inputBorderColor,
      radius: ResponsiveHelper.borderRadius(8),
      child: const SizedBox(),
    );
  }
}