import 'package:flutter/material.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/common/widgets/soft_red_container_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/grade/controller/semistar_controller.dart';
import 'package:gau_app/features/grade/presentation/widgets/grade_shimmer.dart';
import 'package:gau_app/features/home/models/dashboard_model.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  final SemistarController controller = Get.find<SemistarController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initGradeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: const CustomDrawer(),
      ),
      body: Obx(() {
        // if (controller.isDashboardLoading.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        if (controller.isDashboardLoading.value) {
          return const GradeScreenSkeleton();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.height(18)),
                ///cgpa=============================================
                _GPACard(controller: controller),
                SizedBox(height: ResponsiveHelper.height(18)),
                ///semester==============================================
                _SemesterCourseCard(controller: controller),
                SizedBox(height: ResponsiveHelper.height(8)),
                SoftRedContainerWidget(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Course Detail Dialog
// ─────────────────────────────────────────────────────────────────────────────

void showCourseDetailDialog(BuildContext context, Courses course) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(16)),
      ),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseCode ?? '',
                        style: context.titleMedium,
                      ),
                      Text(
                        course.courseName ?? '',
                        style: context.bodySmall.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.greyTextColor,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: ResponsiveHelper.height(16)),
            CustomDivider(),
            SizedBox(height: ResponsiveHelper.height(16)),

            // Detail Rows
            _DialogDetailRow(
              label: 'Instructor',
              value: course.instructor?.isNotEmpty == true
                  ? course.instructor!
                  : 'N/A',
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            _DialogDetailRow(
              label: 'Credits',
              value: course.credits?.toString() ?? '--',
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            _DialogDetailRow(
              label: 'Letter Grade',
              value: course.letterGrade ?? '--',
              valueColor: AppColors.darkRed,
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            _DialogDetailRow(
              label: 'Grade Point',
              value: course.gradePoint?.toStringAsFixed(2) ?? '--',
            ),
            SizedBox(height: ResponsiveHelper.height(12)),
            _DialogDetailRow(
              label: 'Percentage',
              value: course.percentage != null
                  ? '${course.percentage}%'
                  : '--',
            ),

            SizedBox(height: ResponsiveHelper.height(20)),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveHelper.height(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: context.bodyMedium.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _DialogDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DialogDetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(color: AppColors.greyTextColor),
        ),
        Text(
          value,
          style: context.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.black,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GPA & Credits Card
// ─────────────────────────────────────────────────────────────────────────────

class _GPACard extends StatelessWidget {
  final SemistarController controller;
  const _GPACard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
      width: double.infinity,
      borderColor: AppColors.inputBorderColor,
      backgroundColor: AppColors.containerGreyBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.myGrades, style: context.titleMedium),
          Text(
            AppText.viewAcademicPerformance,
            style: context.bodyMedium.copyWith(color: AppColors.greyTextColor),
          ),
          SizedBox(height: ResponsiveHelper.height(16)),
          Center(
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBorderColor),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadius(16),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.height(20),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softRed,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              ResponsiveHelper.borderRadius(16),
                            ),
                            bottomLeft: Radius.circular(
                              ResponsiveHelper.borderRadius(16),
                            ),
                          ),
                        ),
                        child: StatColumn(
                          label: AppText.currentGpa,
                          value: controller.currentGPA,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: 2,
                      thickness: 1,
                      color: AppColors.dividerColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveHelper.height(20),
                        ),
                        child: StatColumn(
                          label: AppText.credits,
                          value: controller.totalEarnedCredits,
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
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Semester Course Table Card
// ─────────────────────────────────────────────────────────────────────────────

class _SemesterCourseCard extends StatelessWidget {
  final SemistarController controller;
  const _SemesterCourseCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderColor: AppColors.inputBorderColor,
      backgroundColor: AppColors.white,
      width: double.infinity,
      radius: ResponsiveHelper.borderRadius(12),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(height: ResponsiveHelper.height(16)),

          // ── Dropdown Row ──────────────────────────────────────────────────
          Padding(
            padding: ResponsiveHelper.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                      () => Text(
                    controller.selectedSemesterName.value ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Obx(
                      () => CustomContainer(
                    padding: ResponsiveHelper.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    borderColor: AppColors.inputBorderColor,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedSemesterName.value,
                        items: controller.semesterNames
                            .map(
                              (name) => DropdownMenuItem(
                            value: name,
                            child: Text(name, style: context.bodySmall),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.onSemesterSelected(value);
                          }
                        },
                        hint: Text(
                          'Select Semester',
                          style: context.bodySmall.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        icon: CustomImage(imageSrc: AppAssets.dropDown),
                        dropdownColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ResponsiveHelper.height(8)),
          CustomDivider(),

          // ── Table Header ──────────────────────────────────────────────────
          CustomContainer(
            backgroundColor: AppColors.containerGreyBgColor,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppText.code,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
                Text(
                  AppText.courseName,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
          CustomDivider(),

          // ── Course Rows ───────────────────────────────────────────────────
          Obx(() {
            if (controller.isSemesterLoading.value) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(24),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final courses = controller.selectedCourses;

            if (courses.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.height(24),
                ),
                child: Center(
                  child: Text(
                    'No courses found',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Column(
                  children: [
                    // ── Tappable Course Row ───────────────────────────────
                    InkWell(
                      onTap: () => showCourseDetailDialog(context, course),
                      child: Padding(
                        padding: ResponsiveHelper.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.courseCode ?? '',
                                  style: context.bodySmall,
                                ),
                                Text(
                                  course.courseName ?? '',
                                  style: context.bodySmall,
                                ),
                              ],
                            ),
                            Text(
                              course.instructor ?? '',
                              style: context.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomDivider(),
                  ],
                );
              },
            );
          }),

          // ── Semester GPA Footer ───────────────────────────────────────────
          Obx(
                () => Padding(
              padding: EdgeInsets.only(
                left: ResponsiveHelper.padding(20),
                right: ResponsiveHelper.padding(20),
                bottom: ResponsiveHelper.padding(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ResponsiveHelper.height(8)),
                  Text(
                    '${AppText.semesterGpa}${controller.selectedSemesterGPA}',
                    style: context.bodyMedium,
                  ),
                  SizedBox(height: ResponsiveHelper.height(8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// StatColumn
// ─────────────────────────────────────────────────────────────────────────────

class StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const StatColumn({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
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
        SizedBox(height: ResponsiveHelper.height(4)),
        Text(value, style: context.titleLarge),
      ],
    );
  }
}