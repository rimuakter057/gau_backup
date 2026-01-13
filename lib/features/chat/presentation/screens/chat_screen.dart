import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/core/router/route_path.dart';
import 'package:gau_app/features/chat/presentation/widgets/user_chat_list_widget.dart';
import 'package:gau_app/features/common/widgets/custom_app_bar.dart';
import 'package:gau_app/features/common/widgets/custom_drawer.dart';


import 'package:gau_app/share/widgets/custom_appbar/custom_appbar.dart';
import 'package:gau_app/share/widgets/custom_search_bar/custom_search_bar.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        child: CustomDrawer(),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: AppText.searchConver
                ),
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return UserChatListWidget(
                    onTap: () {
                     context.pushNamed(RoutesPath.chatInboxScreen);
                    },
                    name: 'Georgiaa',
                    message: 'its urgentt do it asap',
                    time: '3:15 pm',
                    count: '4',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
