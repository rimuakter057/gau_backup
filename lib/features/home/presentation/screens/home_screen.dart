import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/common/widgets/grade_gpa_widget.dart';
import 'package:gau_app/features/common/widgets/soft_red_container_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Courses
  final List<Map<String, String>> courses = [
    {"code": "CS301", "name": "Data Structures"},
    {"code": "MATH202", "name": "Linear Algebra"},
    {"code": "ENG102", "name": "Academic Writing"},
    {"code": "PHYS101", "name": "Physics I"},
    {"code": "CS301", "name": "Data Structures"},
    {"code": "MATH202", "name": "Linear Algebra"},
    {"code": "ENG102", "name": "Academic Writing"},
    {"code": "PHYS101", "name": "Physics I"},
  ];

  // Upcoming Deadlines
  final List<Map<String, String>> deadlines = [
    {"title": "Assignment 1", "date": "12 Feb 2026"},
    {"title": "Midterm Exam", "date": "18 Feb 2026"},
    {"title": "Project Submission", "date": "25 Feb 2026"},
    {"title": "Assignment 1", "date": "12 Feb 2026"},
    {"title": "Midterm Exam", "date": "18 Feb 2026"},
    {"title": "Project Submission", "date": "25 Feb 2026"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(

        onNotificationTap: () {},
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// My Grades============================================
            CustomContainer(
              padding: EdgeInsets.all(24.w),
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
                  SizedBox(height: 16.h),
                  Center(
                    child: GradGpaContainerWidget(
                      borderColor: AppColors.softRedBoarder,
                      bgColor: AppColors.softRed,
                      title: AppText.currentGpa,
                      number: 3.67,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),

            CustomContainer(
              borderColor: AppColors.inputBorderColor,
              backgroundColor: AppColors.white,
              radius: 12,
              padding: EdgeInsets.all(0), // optional
              child: CourseTable(courses: courses),
            ),

            SizedBox(height: 18.h),

            SoftRedContainerWidget(),
            SizedBox(height: 18.h),
            // Quick Options Row 1
            Row(
              children: [
                _buildContainerOption(
                  context,
                  title: AppText.transcript,
                  image: AppAssets.transcript,
                  onTap: () {
                    context.push(RoutesPath.transcriptScreen.addBasePath);
                  },
                ),
                SizedBox(width: 8.w),
                _buildContainerOption(
                  context,
                  title: AppText.complaint,
                  image: AppAssets.complain,
                  onTap: () {
                    context.push(RoutesPath.complainScreen.addBasePath);
                  },
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Quick Options Row 2
            Row(
              children: [
                _buildContainerOption(
                  context,
                  title: AppText.profile,
                  image: AppAssets.profile,
                  onTap: () {
                    context.push(RoutesPath.profileScreen.addBasePath);
                  },
                ),
                Expanded(child: SizedBox(width: 12.w)),

                // _buildContainerOption(
                //   context,
                //   title: AppText.badges,
                //   image: AppAssets.badges,
                //   onTap: () {
                //    // context.push(RoutePath.profileScreen.addBasePath);
                //   },
                // ),

                SizedBox(),

              ],
            ),
            SizedBox(height: 18.h),

            /// Upcoming Deadlines=================================================
            CustomContainer(
              width: double.infinity,
              backgroundColor: AppColors.containerGreyBgColor,
              borderColor: AppColors.inputBorderColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.upcomingDeadlines,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h,),
                  CustomDivider(color: AppColors.dividerColor),
                  deadlines.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text(
                            "No upcoming deadlines",
                            style: context.bodySmall.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: deadlines.length,
                          separatorBuilder: (_, __) =>
                              CustomDivider(color: AppColors.dividerColor),
                          itemBuilder: (context, index) {
                            final item = deadlines[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  CircleAvatar(backgroundColor: AppColors.primaryColor,
                                    minRadius: 5,
                                  ),
                                      SizedBox(width: 6,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.titleColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        item['date']!,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.greyTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            ///academic progress===================================================
            CustomContainer(
              width: double.infinity,
              backgroundColor: AppColors.containerGreyBgColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.academicProgress,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.titleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomDivider(color: AppColors.dividerColor),
                  _buildAcademicProgressText(
                    context,
                    title: AppText.degree,
                    progress: "32.5%",
                  ),
                  SizedBox(height: 12.h),

                  ///progress bar====================================================




                 LinearProgressIndicator(
                   value:  32 / 100,
                   color: AppColors.primaryColor,
                   minHeight:12.h,
                   borderRadius: BorderRadius.circular(6.r),
                   backgroundColor: AppColors.dividerColor,


                 ),



                  SizedBox(height: 12.h),
                  Text(
                    AppText.recentSemesters,
                    style: context.bodySmall.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 12.h),
                  _buildAcademicProgressText(
                    context,
                    title: AppText.spring,
                    progress: "32.5%",
                  ),
                  SizedBox(height: 8.h),
                  _buildAcademicProgressText(
                    context,
                    title: AppText.spring,
                    progress: "32.5%",
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h,),
          ],
        ),
      ),
    );
  }

  ///academic progress================================================================
  Row _buildAcademicProgressText(
    BuildContext context, {
    required String title,
    required String progress,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.bodySmall),
        Text(
          progress,
          style: context.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.titleColor,
          ),
        ),
      ],
    );
  }

  // Quick Option Cards
  Expanded _buildContainerOption(
    BuildContext context, {
    required String title,
    required String image,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CustomContainer(
          borderWidth: 2,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          borderColor: AppColors.red,
          child: Column(
            children: [
              CustomImage(imageSrc: image),
              SizedBox(height: 4.h),
              Text(
                title,
                style: context.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// Course Table
class CourseTable extends StatelessWidget {
  final List<Map<String, String>> courses;
  const CourseTable({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.currentCourses, style: context.bodyMedium),
          SizedBox(height: 12.h),
          CustomDivider(),
          const _RowItem(code: 'Code', name: 'Course Name', isHeader: true),
          CustomDivider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final course = courses[index];
              return _RowItem(code: course['code']!, name: course['name']!);
            },
          ),
        ],
      ),
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
    final style = TextStyle(
      color: isHeader ? Colors.blueGrey[400] : Colors.blueGrey[700],
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontSize: 15,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Text(code, style: style)),
          Expanded(
            child: Text(name, style: style, textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}
