import 'package:flutter/material.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';
import 'package:gau_app/features/home/controller/home_controller.dart'
    show HomeController;
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  final HomeController controller = Get.find<HomeController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // ✅ Bug 1 Fix: Listener একবারই initState-এ register হবে,
    // build()-এ না — নাহলে প্রতিটি rebuild-এ duplicate listener যোগ হতো
    scrollController.addListener(() {
      if (!controller.isLoading.value &&   // ✅ Bug 2 Fix: initial load চলাকালীন trigger হবে না
          scrollController.hasClients &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllComplaints();
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // ✅ memory leak এড়াতে dispose করা হয়েছে
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onNotificationTap: () {
          context.pushNamed(RoutesPath.notificationScreen);
        },
      ),
      drawer: Drawer(
        backgroundColor: AppColors.drawerBgColor,
        child: CustomDrawer(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchAllComplaints(isRefresh: true);
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.height(16),
            ),
            child: Column(
              children: [
                CustomContainer(
                  padding: EdgeInsets.all(ResponsiveHelper.padding(24)),
                  backgroundColor: AppColors.containerGreyBgColor,
                  borderColor: AppColors.inputBorderColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppText.myComplaints, style: context.titleMedium),
                      SizedBox(height: ResponsiveHelper.height(4)),
                      Text(
                        AppText.trackStatusAndUpdates,
                        style: context.bodySmall,
                      ),
                      SizedBox(height: ResponsiveHelper.height(24)),
                      ElevatedButton(
                        onPressed: () {
                          context.push(
                              RoutesPath.addComplainScreen.addBasePath);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImage(imageSrc: AppAssets.add),
                            SizedBox(width: ResponsiveHelper.width(12)),
                            Text(AppText.complaint),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveHelper.height(24)),
                Obx(() {
                  if (controller.isLoading.value &&
                      controller.complaintsList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.complaintsList.isEmpty) {
                    return const Center(child: Text("No complaints found"));
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.complaintsList.length +
                        (controller.isMoreLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < controller.complaintsList.length) {
                        final item = controller.complaintsList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                RoutesPath.complainDetailsScreen,
                                extra: item.id,
                              );
                            },
                            child: Card(
                              color: AppColors.white,
                              child: Padding(
                                padding: ResponsiveHelper.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item.subject ?? "No Subject"),
                                        Container(
                                          padding:
                                          ResponsiveHelper.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            item.status ?? "pending",
                                            style: context.bodySmall.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height: ResponsiveHelper.spacing(6)),
                                    Text(
                                      item.description ?? "No Description",
                                      style: context.bodySmall.copyWith(
                                        color: AppColors.greyTextColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}