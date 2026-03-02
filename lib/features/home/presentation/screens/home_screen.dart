import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/common/widgets/grade_gpa_widget.dart';
import 'package:gau_app/features/common/widgets/soft_red_container_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/home/controller/home_controller.dart';
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
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Courses
  final List<Map<String, String>> coursesDetails = [
    {"code": "CS301", "name": "Data Structures","Instructor":"Dr. Smith"},
    {"code": "MATH202", "name": "Linear Algebra","Instructor":"Dr. Smith"},
    {"code": "ENG102", "name": "Academic Writing","Instructor":"Dr. Smith"},


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

  final HomeController controller=Get.find<HomeController>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){

      controller.fetchUpcomingDeadlines();

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(


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
            SizedBox(height:  ResponsiveHelper.height(18)),
           ///current course=======================================
            CustomContainer(
              borderColor: AppColors.inputBorderColor,
              backgroundColor: AppColors.white,
              width: double.infinity,
              radius:  ResponsiveHelper.borderRadius(12),
              padding: EdgeInsets.zero,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Padding(
                  padding:  ResponsiveHelper.all(8.0),
                  child: Text(AppText.currentCourses, style: context.bodyMedium),
                ),
                SizedBox(height:  ResponsiveHelper.height(12)),

         CustomDivider(),
                CustomContainer(

    backgroundColor: AppColors.containerGreyBgColor,
    width: double.infinity,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppText.course, style: context.bodyMedium.copyWith(color: AppColors.greyTextColor)),
          Text(AppText.instructor, style: context.bodyMedium.copyWith(color: AppColors.greyTextColor)),
        ],
      ),
    ),
                  CustomDivider(),

/// course details apply listview builder========================================

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: coursesDetails.length,
                    itemBuilder: (context, index) {
                      final course = coursesDetails[index];
                      return Column(
                        children: [
                          Padding(
                            padding: ResponsiveHelper.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(course['code']!, style: context.bodySmall),
                                    Text(course['name']!, style: context.bodySmall),
                                  ],
                                ),
                                Text(course['Instructor']!, style: context.bodySmall),
                              ],
                            ),
                          ),
                          // শেষ আইটেম না হলে divider দেখাবে
                          if (index != coursesDetails.length - 1)
                            CustomDivider(),
                        ],
                      );
                    },
                  )






                ],)
             // child: CourseTable(courses: courses),
            ),

            SizedBox(height:  ResponsiveHelper.height(18)),

            SoftRedContainerWidget(),
            SizedBox(height:  ResponsiveHelper.height(18)),
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
                SizedBox(width:  ResponsiveHelper.width(8)),
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
            SizedBox(height:  ResponsiveHelper.height(12)),

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
                Expanded(child: SizedBox(width:  ResponsiveHelper.width(12))),

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
            SizedBox(height:  ResponsiveHelper.height(18)),

            /// Upcoming Deadlines=================================================

            Obx((){

              if(controller.isDeadlineLoading.value){
                return const Center(child: CircularProgressIndicator(),);
              }

              if(controller.upcomingDeadlines.isEmpty){
                return const Center(child: Text("No Upcoming Deadlines"),);

              }




              return   CustomContainer(
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
                    SizedBox(height: ResponsiveHelper.height(6),),
                    CustomDivider(color: AppColors.dividerColor),
                    deadlines.isEmpty
                        ? Padding(
                      padding: EdgeInsets.symmetric(vertical:  ResponsiveHelper.height(16)),
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
                     // itemCount: deadlines.length,
                     itemCount:  controller.upcomingDeadlines.length,
                      separatorBuilder: (_, __) =>
                          CustomDivider(color: AppColors.dividerColor),
                      itemBuilder: (context, index) {
                        //final item = deadlines[index];

                        final deadline = controller.upcomingDeadlines[index];
                        final String? dateStr = deadline.dueDate; // "2026-02-12"
                        final String? timeStr = deadline.dueTime; // "15:45:00"

                        DateTime? dateTime;
                        if (dateStr != null && timeStr != null) {
                          dateTime = DateTime.tryParse('$dateStr $timeStr');
                        }

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal:  ResponsiveHelper.padding(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CircleAvatar(backgroundColor: AppColors.primaryColor,
                                minRadius: 5,
                              ),
                              SizedBox(width: ResponsiveHelper.width(6),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(

                                    deadline.title ?? "",
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.titleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),



                                  /// DATE
                                  Row(
                                    mainAxisSize: MainAxisSize.min, // shrink to fit children
                                    children: [
                                      Flexible(
                                        child: Text(
                                          deadline.deadlineType ?? "",
                                          style: context.bodySmall.copyWith(fontSize: ResponsiveHelper.fontSize(14))
                                        ),
                                      ),
                                      SizedBox(width: ResponsiveHelper.spacing(6),),



                                      Flexible(
                                        child: Text(
                                          '(${DateConverter.formatDateTime(dateTime: dateTime)})',
                                          style: context.bodySmall,
                                        ),
                                      )


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


            }),





            SizedBox(height:  ResponsiveHelper.height(32)),

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
                  SizedBox(height:  ResponsiveHelper.height(12)),

                  ///progress bar====================================================




                 LinearProgressIndicator(
                   value:  32 / 100,
                   color: AppColors.primaryColor,
                   minHeight: ResponsiveHelper.height(12),
                   borderRadius: BorderRadius.circular( ResponsiveHelper.borderRadius(6)),
                   backgroundColor: AppColors.dividerColor,


                 ),



                  SizedBox(height:  ResponsiveHelper.height(12)),
                  Text(
                    AppText.recentSemesters,
                    style: context.bodySmall.copyWith(fontSize:  ResponsiveHelper.fontSize(16)),
                  ),
                  SizedBox(height:  ResponsiveHelper.height(12)),
                  _buildAcademicProgressText(
                    context,
                    title: AppText.spring,
                    progress: "32.5%",
                  ),
                  SizedBox(height:  ResponsiveHelper.height(8)),
                  _buildAcademicProgressText(
                    context,
                    title: AppText.spring,
                    progress: "32.5%",
                  ),
                ],
              ),
            ),

            SizedBox(height:  ResponsiveHelper.height(24),),
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
          borderWidth: ResponsiveHelper.width(2),
          padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.padding(24), vertical:  ResponsiveHelper.padding(24)),
          borderColor: AppColors.red,
          child: Column(
            children: [
              CustomImage(imageSrc: image),
              SizedBox(height:  ResponsiveHelper.height(4)),
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






