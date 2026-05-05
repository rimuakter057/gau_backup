
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/common/widgets/grade_gpa_widget.dart';
import 'package:gau_app/features/common/widgets/soft_red_container_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/grade/controller/semistar_controller.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
import 'package:gau_app/features/home/models/current_course_model.dart';
import 'package:gau_app/features/home/presentation/widgets/home_screen_skeliton.dart';
import 'package:gau_app/helper/date_converter/date_converter.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_divider/custom_divider.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final SemistarController dashboardController = Get.find<SemistarController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchUpcomingDeadlines();
      homeController.fetchAcademicProgress();
      homeController.fetchCurrentCourses();
      dashboardController.fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),

      // ✅ Shimmer: যেকোনো একটা loading true হলেই skeleton দেখাবে
      body: Obx(() {
        final isLoading =
            homeController.isCurrentCourseLoading.value ||
                homeController.isDeadlineLoading.value ||
                homeController.isProgressLoading.value ||
                dashboardController.isDashboardLoading.value;

        if (isLoading) {
          return const HomeScreenSkeleton();
        }

        // ── আসল content ─────────────────────────────────────────────────
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ── My Grades / GPA ─────────────────────────────────────
              _buildGpaSection(context),

              SizedBox(height: ResponsiveHelper.height(18)),

              /// ── Current Courses ──────────────────────────────────────
              _buildCurrentCoursesSection(context),

              SizedBox(height: ResponsiveHelper.height(18)),

              /// ── Static Design Line ───────────────────────────────────
              SoftRedContainerWidget(),
              SizedBox(height: ResponsiveHelper.height(18)),

              // Quick Options Row
              Row(
                children: [
                  _buildContainerOption(
                    context,
                    title: AppText.complaint,
                    image: AppAssets.complain,
                    onTap: () => context.push(RoutesPath.complainScreen.addBasePath),
                  ),
                  SizedBox(width: ResponsiveHelper.width(8)),
                  _buildContainerOption(
                    context,
                    title: AppText.profile,
                    image: AppAssets.profile,
                    onTap: () => context.push(RoutesPath.profileScreen.addBasePath),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveHelper.height(18)),

              /// ── Upcoming Deadlines ───────────────────────────────────
              _buildUpcomingDeadlinesSection(context),

              SizedBox(height: ResponsiveHelper.height(32)),

              /// ── Academic Progress ────────────────────────────────────
              _buildAcademicProgressSection(context),

              SizedBox(height: ResponsiveHelper.height(24)),
            ],
          ),
        );
      }),
    );
  }

  // ── GPA Section ────────────────────────────────────────────────────────────
  Widget _buildGpaSection(BuildContext context) {
    final gpa = dashboardController.semistarData.value?.currentGPA ?? 0.0;

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
            child: GradGpaContainerWidget(
              borderColor: AppColors.softRedBoarder,
              bgColor: AppColors.softRed,
              title: AppText.currentGpa,
              number: gpa,
            ),
          ),
        ],
      ),
    );
  }

  // ── Current Courses Section ────────────────────────────────────────────────
  Widget _buildCurrentCoursesSection(BuildContext context) {
    final courses = homeController.currentCourses;

    return CustomContainer(
      borderColor: AppColors.inputBorderColor,
      backgroundColor: AppColors.white,
      width: double.infinity,
      radius: ResponsiveHelper.borderRadius(12),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ResponsiveHelper.all(8.0),
            child: Text(AppText.currentCourses, style: context.bodyMedium),
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          CustomDivider(),
          CustomContainer(
            backgroundColor: AppColors.containerGreyBgColor,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppText.course,
                    style: context.bodyMedium
                        .copyWith(color: AppColors.greyTextColor)),
                Text(AppText.instructor,
                    style: context.bodyMedium
                        .copyWith(color: AppColors.greyTextColor)),
              ],
            ),
          ),
          CustomDivider(),
          courses.isEmpty
              ? Padding(
            padding: EdgeInsets.all(ResponsiveHelper.padding(12)),
            child: Text(
              "No courses available at the moment. Stay tuned for upcoming courses!",
              style: context.bodySmall
                  .copyWith(color: AppColors.greyTextColor),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () =>
                        _showCourseDetailsDialog(context, course),
                    child: Padding(
                      padding: ResponsiveHelper.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(course.courseCode ?? '',
                                  style: context.bodySmall),
                              Text(course.courseName ?? '',
                                  style: context.bodySmall),
                            ],
                          ),
                          Text(
                            course.advisorId?.fullName ?? 'N/A',
                            style: context.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index != courses.length - 1) CustomDivider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Upcoming Deadlines Section ─────────────────────────────────────────────
  Widget _buildUpcomingDeadlinesSection(BuildContext context) {
    if (homeController.upcomingDeadlines.isEmpty) {
      return const Center(child: Text("You have no upcoming deadlines"));
    }

    return CustomContainer(
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
          SizedBox(height: ResponsiveHelper.height(6)),
          CustomDivider(color: AppColors.dividerColor),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeController.upcomingDeadlines.length,
            separatorBuilder: (_, __) =>
                CustomDivider(color: AppColors.dividerColor),
            itemBuilder: (context, index) {
              final deadline = homeController.upcomingDeadlines[index];
              final String? dateStr = deadline.dueDate;
              final String? timeStr = deadline.dueTime;

              DateTime? dateTime;
              if (dateStr != null && timeStr != null) {
                dateTime = DateTime.tryParse('$dateStr $timeStr');
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: ResponsiveHelper.padding(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      minRadius: 5,
                    ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          deadline.title ?? "",
                          style: context.bodySmall.copyWith(
                            color: AppColors.titleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                deadline.deadlineType ?? "",
                                style: context.bodySmall.copyWith(
                                    fontSize: ResponsiveHelper.fontSize(14)),
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.spacing(6)),
                            Flexible(
                              child: Text(
                                '(${DateConverter.formatDateTime(dateTime: dateTime)})',
                                style: context.bodySmall,
                              ),
                            ),
                          ],
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
    );
  }

  // ── Academic Progress Section ──────────────────────────────────────────────
  Widget _buildAcademicProgressSection(BuildContext context) {
    final progress = homeController.academicProgress.value;
    final degreePercent = progress?.degreeCompletionPercent ?? 0;

    return CustomContainer(
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
            progress: "$degreePercent%",
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          LinearProgressIndicator(
            value: degreePercent / 100,
            color: AppColors.primaryColor,
            minHeight: ResponsiveHelper.height(12),
            borderRadius:
            BorderRadius.circular(ResponsiveHelper.borderRadius(6)),
            backgroundColor: AppColors.dividerColor,
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          Text(
            AppText.recentSemesters,
            style: context.bodySmall.copyWith(
              fontSize: ResponsiveHelper.fontSize(16),
              color: AppColors.black,
            ),
          ),
          SizedBox(height: ResponsiveHelper.height(12)),
          if (progress?.recentSemesters != null &&
              progress!.recentSemesters!.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: progress.recentSemesters!.length,
              separatorBuilder: (_, __) =>
                  SizedBox(height: ResponsiveHelper.height(8)),
              itemBuilder: (context, index) {
                final semester = progress.recentSemesters![index];
                return _buildAcademicProgressText(
                  context,
                  title: semester.label ?? "",
                  progress: "GPA: ${semester.gpa ?? 0}",
                );
              },
            )
          else
            Text(
              "You don't have any recent semesters",
              style:
              context.bodySmall.copyWith(color: AppColors.greyTextColor),
            ),
        ],
      ),
    );
  }

  // ── Course Details Dialog ──────────────────────────────────────────────────
  void _showCourseDetailsDialog(
      BuildContext context, CurrentCourseModel course) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(ResponsiveHelper.borderRadius(16)),
        ),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.padding(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      course.courseName ?? 'Course Details',
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                    Icon(Icons.close, color: AppColors.greyTextColor),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveHelper.height(4)),
              Text(
                course.courseCode ?? '',
                style: context.bodySmall
                    .copyWith(color: AppColors.primaryColor),
              ),
              SizedBox(height: ResponsiveHelper.height(16)),
              CustomDivider(color: AppColors.dividerColor),
              SizedBox(height: ResponsiveHelper.height(12)),

              // Detail Rows
              _buildDialogRow(context,
                  label: "Section", value: course.section ?? 'N/A'),
              _buildDialogRow(context,
                  label: "Credits", value: "${course.credits ?? 0}"),
              _buildDialogRow(context,
                  label: "Semester", value: course.semester ?? 'N/A'),
              _buildDialogRow(context,
                  label: "Academic Year",
                  value: "${course.academicYear ?? 'N/A'}"),
              _buildDialogRow(context,
                  label: "Program", value: course.program ?? 'N/A'),
              _buildDialogRow(context,
                  label: "Advisor",
                  value: course.advisorId?.fullName ?? 'N/A'),

              if (course.classRoomId != null) ...[
                _buildDialogRow(context,
                    label: "Building",
                    value: course.classRoomId?.building ?? 'N/A'),
                _buildDialogRow(context,
                    label: "Room",
                    value:
                    "${course.classRoomId?.roomName ?? ''} (${course.classRoomId?.roomNumber ?? ''})"),
              ],

              if (course.sectionTime != null) ...[
                SizedBox(height: ResponsiveHelper.height(8)),
                _buildDialogRow(context,
                    label: "Class Time",
                    value:
                    "${course.sectionTime?.startTime ?? ''} - ${course.sectionTime?.endTime ?? ''}"),
              ],

              if (course.sectionDays != null &&
                  course.sectionDays!.isNotEmpty) ...[
                SizedBox(height: ResponsiveHelper.height(8)),
                _buildDialogRow(context,
                    label: "Days",
                    value: course.sectionDays!.join(', ')),
              ],

              SizedBox(height: ResponsiveHelper.height(20)),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(8)),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Close",
                    style:
                    context.bodySmall.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Row _buildAcademicProgressText(BuildContext context,
      {required String title, required String progress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: context.bodySmall.copyWith(color: AppColors.black)),
        Text(progress,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.titleColor,
            )),
      ],
    );
  }

  Widget _buildDialogRow(BuildContext context,
      {required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: context.bodySmall
                  .copyWith(color: AppColors.greyTextColor)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          borderWidth: ResponsiveHelper.width(2),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.padding(24),
            vertical: ResponsiveHelper.padding(24),
          ),
          borderColor: AppColors.red,
          child: Column(
            children: [
              CustomImage(imageSrc: image),
              SizedBox(height: ResponsiveHelper.height(4)),
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