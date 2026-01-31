import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/common/widgets/soft_red_container_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class GradeScreen extends StatelessWidget {
  GradeScreen({super.key});
  final List<Map<String, String>> courses = [
    {"code": "CS301", "name": "Data Structures"},
    {"code": "MATH202", "name": "Linear Algebra"},
    {"code": "ENG102", "name": "Academic Writing"},
    {"code": "PHYS101", "name": "Physics I"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(


        onNotificationTap: () {
          // context.pushNamed(RoutePath.notificationScreen);
        },
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,

        child: const CustomDrawer(),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all( ResponsiveHelper.padding(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomContainer(
                padding: EdgeInsets.all( ResponsiveHelper.padding(24)),
                width: double.infinity,
                borderColor: AppColors.inputBorderColor,
                backgroundColor: AppColors.containerGreyBgColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppText.myGrades, style: context.titleMedium),
                    Text(
                      AppText.viewAcademicPerformance,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    SizedBox(height:  ResponsiveHelper.height(16)),

                    Center(
                      child: IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.inputBorderColor,
                            ),
                            borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(16)),
                          ),
                          child: Row(
                            children: [
                              // Current GPA Section
                              Expanded(
                                child: Container(
                                  padding:  EdgeInsets.symmetric(
                                    vertical:  ResponsiveHelper.height(20),
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softRed,
                                    borderRadius:  BorderRadius.only(
                                      topLeft: Radius.circular( ResponsiveHelper.borderRadius(16)),
                                      bottomLeft: Radius.circular( ResponsiveHelper.borderRadius(16)),
                                    ),
                                  ),
                                  child: const StatColumn(
                                    label: AppText.currentGpa,
                                    value: '3.67',
                                  ),
                                ),
                              ),
                              // Vertical Divider
                              VerticalDivider(
                                width: 2,
                                thickness: 1,
                                color: AppColors.dividerColor,
                              ),
                              // Credits Section
                               Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical:  ResponsiveHelper.height(20)),
                                  child: StatColumn(
                                    label: AppText.credits,
                                    value: '88',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Center(
                child: Container(
                  margin:  EdgeInsets.all( ResponsiveHelper.padding(20)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(12)),
                    border: Border.all(color: AppColors.inputBorderColor),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TabBar(
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: AppColors.darkRed,
                          unselectedLabelColor: AppColors.labelTextColor,
                          indicatorColor: AppColors.darkRed,
                          tabs: const [
                            Tab(text: "${AppText.fall}2024"),
                            Tab(text: "${AppText.spring}2024"),
                          ],
                        ),

                        SizedBox(
                          height:  ResponsiveHelper.height(400),
                          child: TabBarView(
                            children: [
                              CourseTable(courses: courses),
                              CourseTable(courses: courses),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SoftRedContainerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  ///drawer==================================================
}

//===========================================================================

class CourseTable extends StatelessWidget {
  final List<Map<String, String>> courses;

  const CourseTable({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        const _RowItem(code: 'Code', name: 'Course Name', isHeader: true),
        const CustomDivider(color: AppColors.inputBorderColor),

        // List (takes remaining space)
        Expanded(
          child: ListView.builder(
            padding:  EdgeInsets.only(bottom:  ResponsiveHelper.height(12)),
            itemCount: courses.length + 1,
            itemBuilder: (context, index) {
              if (index == courses.length) {
                return const CustomDivider(color: AppColors.inputBorderColor);
              }

              final course = courses[index];
              return Column(
                children: [
                  _RowItem(code: course['code']!, name: course['name']!),
                  const CustomDivider(color: AppColors.inputBorderColor),
                ],
              );
            },
          ),
        ),

        // Footer
        Padding(
          padding:  EdgeInsets.all( ResponsiveHelper.padding(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${AppText.semesterGpa}3.72", style: context.bodyMedium),
               SizedBox(height:  ResponsiveHelper.height(8)),
              GestureDetector(
                onTap: (){

                  context.pushNamed(RoutesPath.gradeReqScreen);

                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomImage(imageSrc: AppAssets.reqGrade),

                    SizedBox(width:  ResponsiveHelper.width(4)),



                    Text(
                      AppText.requestGradeVerification,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        decorationThickness: 1.5,
                      ),


                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  final String code;
  final String name;
  final bool isHeader;

  const _RowItem({
    required this.code,
    required this.name,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isHeader ? AppColors.containerGreyBgColor : AppColors.white,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:  ResponsiveHelper.width(20), vertical:  ResponsiveHelper.height(18)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                code,
                style: context.bodySmall.copyWith(
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                  fontSize: isHeader ?  ResponsiveHelper.fontSize(14) :  ResponsiveHelper.fontSize(12),
                ),
              ),
            ),
            Expanded(
              child: Text(
                name,
                style: context.bodySmall.copyWith(
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                  fontSize: isHeader ?  ResponsiveHelper.fontSize(14) :  ResponsiveHelper.fontSize(12),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///===================================================================

class StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const StatColumn({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    // Matches the deep maroon color in the image
    const Color brandColor = Color(0xFF7B1D1D);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            color: AppColors.darkRed,
            fontWeight: FontWeight.w600,
          ),
        ),
         SizedBox(height:  ResponsiveHelper.height(4)),
        Text(value, style: context.titleLarge),
      ],
    );
  }
}
