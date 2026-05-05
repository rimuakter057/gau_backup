import 'package:flutter/material.dart';
import 'package:gau_app/features/common/widgets/custom_shimmer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/utils/color/app_colors.dart';

class HomeScreenSkeleton extends StatelessWidget {
  const HomeScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return CustomShimmer(
      child: SingleChildScrollView(
        child: Padding(
          padding: ResponsiveHelper.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GpaCardSkeleton(),
              SizedBox(height: ResponsiveHelper.height(18)),

              _CurrentCoursesSkeleton(),
              SizedBox(height: ResponsiveHelper.height(18)),

              ShimmerBox(
                height: ResponsiveHelper.height(90),
                borderRadius: ResponsiveHelper.borderRadius(12),
              ),

              SizedBox(height: ResponsiveHelper.height(18)),

              Row(
                children: [
                  Expanded(child: _QuickOptionSkeleton()),
                  SizedBox(width: ResponsiveHelper.width(8)),
                  Expanded(child: _QuickOptionSkeleton()),
                ],
              ),

              SizedBox(height: ResponsiveHelper.height(18)),

              _UpcomingDeadlinesSkeleton(),

              SizedBox(height: ResponsiveHelper.height(32)),

              _AcademicProgressSkeleton(),

              SizedBox(height: ResponsiveHelper.height(24)),
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
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.all(12),
      decoration: BoxDecoration(
        color: AppColors.containerGreyBgColor,
        borderRadius:
        BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
        border: Border.all(color: AppColors.inputBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            width: ResponsiveHelper.width(120),
            height: ResponsiveHelper.height(14),
            borderRadius: 6,
          ),
          SizedBox(height: ResponsiveHelper.height(6)),

          ShimmerBox(
            width: ResponsiveHelper.width(200),
            height: ResponsiveHelper.height(12),
            borderRadius: 6,
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          Center(
            child: Container(
              width: ResponsiveHelper.width(80),
              height: ResponsiveHelper.height(80),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius:
                BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentCoursesSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius:
        BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
        border: Border.all(color: AppColors.inputBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ResponsiveHelper.all(8),
            child: ShimmerBox(
              width: ResponsiveHelper.width(140),
              height: ResponsiveHelper.height(14),
              borderRadius: 6,
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(8)),
          const CustomDivider(),

          Container(
            color: AppColors.containerGreyBgColor,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.padding(12),
              vertical: ResponsiveHelper.height(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(
                  width: ResponsiveHelper.width(70),
                  height: ResponsiveHelper.height(12),
                  borderRadius: 4,
                ),
                ShimmerBox(
                  width: ResponsiveHelper.width(80),
                  height: ResponsiveHelper.height(12),
                  borderRadius: 4,
                ),
              ],
            ),
          ),

          const CustomDivider(),

          ...List.generate(3, (i) => _CourseRowSkeleton(isLast: i == 2)),
        ],
      ),
    );
  }
}

class _CourseRowSkeleton extends StatelessWidget {
  final bool isLast;
  const _CourseRowSkeleton({this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: ResponsiveHelper.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(
                    width: ResponsiveHelper.width(60),
                    height: ResponsiveHelper.height(11),
                    borderRadius: 4,
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  ShimmerBox(
                    width: ResponsiveHelper.width(120),
                    height: ResponsiveHelper.height(11),
                    borderRadius: 4,
                  ),
                ],
              ),
              ShimmerBox(
                width: ResponsiveHelper.width(80),
                height: ResponsiveHelper.height(11),
                borderRadius: 4,
              ),
            ],
          ),
        ),
        if (!isLast) const CustomDivider(),
      ],
    );
  }
}

class _QuickOptionSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.padding(20),
        vertical: ResponsiveHelper.padding(20),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
        borderRadius:
        BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      ),
      child: Column(
        children: [
          ShimmerBox(
            width: ResponsiveHelper.width(40),
            height: ResponsiveHelper.height(40),
            borderRadius: 8,
          ),
          SizedBox(height: ResponsiveHelper.height(6)),
          ShimmerBox(
            width: ResponsiveHelper.width(60),
            height: ResponsiveHelper.height(12),
            borderRadius: 6,
          ),
        ],
      ),
    );
  }
}

class _UpcomingDeadlinesSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.all(12),
      decoration: BoxDecoration(
        color: AppColors.containerGreyBgColor,
        borderRadius:
        BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
        border: Border.all(color: AppColors.inputBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            width: ResponsiveHelper.width(150),
            height: ResponsiveHelper.height(14),
            borderRadius: 6,
          ),

          SizedBox(height: ResponsiveHelper.height(8)),
          CustomDivider(color: AppColors.dividerColor),

          ...List.generate(
            3,
                (_) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelper.height(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerCircle(radius: 5),
                  SizedBox(width: ResponsiveHelper.width(8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBox(
                        width: ResponsiveHelper.width(160),
                        height: ResponsiveHelper.height(12),
                        borderRadius: 4,
                      ),
                      SizedBox(height: ResponsiveHelper.height(5)),
                      ShimmerBox(
                        width: ResponsiveHelper.width(220),
                        height: ResponsiveHelper.height(11),
                        borderRadius: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AcademicProgressSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.all(12),
      decoration: BoxDecoration(
        color: AppColors.containerGreyBgColor,
        borderRadius:
        BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(
            width: ResponsiveHelper.width(140),
            height: ResponsiveHelper.height(14),
            borderRadius: 6,
          ),

          SizedBox(height: ResponsiveHelper.height(8)),
          CustomDivider(color: AppColors.dividerColor),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerBox(
                width: ResponsiveHelper.width(80),
                height: ResponsiveHelper.height(12),
                borderRadius: 4,
              ),
              ShimmerBox(
                width: ResponsiveHelper.width(50),
                height: ResponsiveHelper.height(12),
                borderRadius: 4,
              ),
            ],
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          ShimmerBox(
            width: double.infinity,
            height: ResponsiveHelper.height(12),
            borderRadius: 6,
          ),

          SizedBox(height: ResponsiveHelper.height(14)),

          ShimmerBox(
            width: ResponsiveHelper.width(120),
            height: ResponsiveHelper.height(13),
            borderRadius: 4,
          ),

          SizedBox(height: ResponsiveHelper.height(12)),

          ...List.generate(
            3,
                (_) => Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveHelper.height(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerBox(
                    width: ResponsiveHelper.width(100),
                    height: ResponsiveHelper.height(12),
                    borderRadius: 4,
                  ),
                  ShimmerBox(
                    width: ResponsiveHelper.width(70),
                    height: ResponsiveHelper.height(12),
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}