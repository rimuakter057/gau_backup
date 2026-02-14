import 'package:flutter/material.dart';
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

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  // Backend থেকে যেগুলো আসবে
  List<String> semesters = [];
  String? selectedSemester;

  final List<Map<String, String>> coursesDetails = [
    {"code": "CS301", "name": "Data Structures", "Instructor": "Dr. Smith"},
    {"code": "MATH202", "name": "Linear Algebra", "Instructor": "Dr. Smith"},
    {"code": "ENG102", "name": "Academic Writing", "Instructor": "Dr. Smith"},
  ];

  @override
  void initState() {
    super.initState();
    fetchSemestersFromBackend();
  }

  // Fake backend call
  void fetchSemestersFromBackend() {
    // Example: Backend return ['Semester 1', 'Semester 2', 'Semester 3']
    semesters = ['Semester 1', 'Semester 2', 'Semester 3'];
    selectedSemester = semesters.first; // default
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: const CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveHelper.padding(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: ResponsiveHelper.height(18)),


              CustomContainer(
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
                      style: context.bodyMedium.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.height(16)),

                    Center(
                      child: IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.inputBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.borderRadius(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Current GPA Section
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
                                  padding: EdgeInsets.symmetric(
                                    vertical: ResponsiveHelper.height(20),
                                  ),
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
              SizedBox(height: ResponsiveHelper.height(18)),

              CustomContainer(
                borderColor: AppColors.inputBorderColor,
                backgroundColor: AppColors.white,
                width: double.infinity,
                radius: ResponsiveHelper.borderRadius(12),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(height: ResponsiveHelper.height(16)),




                    Padding(
                      padding: ResponsiveHelper.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left: Selected Semester Text
                          Text(
                            selectedSemester ?? "Semester 1", // or always fixed text if you want
                            style: context.bodyMedium.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),

                          // Right: Dropdown
                          CustomContainer(
                            padding: ResponsiveHelper.symmetric(horizontal: 12, vertical: 4), // nice padding
                            borderColor: AppColors.inputBorderColor,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: null, // fixed, UI text never changes
                                items: semesters
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: context.bodySmall,
                                  ),
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSemester = value;
                                    // backend call or courses update
                                  });
                                },
                                hint: Row(
                                  children: [
                                    Text(
                                      "Select Semester",
                                      style: context.bodySmall.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(width: ResponsiveHelper.width(8)), // gap between text & icon
                                  ],
                                ),
                                icon: CustomImage(imageSrc: AppAssets.dropDown),
                                dropdownColor: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),



                    SizedBox(height: ResponsiveHelper.height(8)),
                    CustomDivider(),

                    // Course Table
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

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: coursesDetails.length,
                      itemBuilder: (context, index) {
                        final course = coursesDetails[index];
                        return Column(
                          children: [
                            Padding(
                              padding: ResponsiveHelper.all(12),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(course['code']!, style: context.bodySmall),
                                      Text(course['name']!, style: context.bodySmall),
                                    ],
                                  ),
                                  Text(course['Instructor']!, style: context.bodySmall),
                                ],
                              ),
                            ),
                            CustomDivider(),
                          ],
                        );
                      },
                    ),

                    // Footer
                    Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveHelper.padding(20),
                        right: ResponsiveHelper.padding(20),
                        bottom: ResponsiveHelper.padding(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppText.semesterGpa}3.72",
                            style: context.bodyMedium,
                          ),
                          SizedBox(height: ResponsiveHelper.height(8)),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(RoutesPath.gradeReqScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomImage(imageSrc: AppAssets.reqGrade),
                                SizedBox(width: ResponsiveHelper.width(4)),
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
                ),
              ),
              SizedBox(height: ResponsiveHelper.height(8),),
              SoftRedContainerWidget(),
            ],
          ),
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
