
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/share/widgets/custom_container/custom_container.dart';
import 'package:gau_app/share/widgets/custom_image/custom_image.dart';
import 'package:gau_app/utils/app_assets/app_assets.dart';
import 'package:gau_app/utils/app_text/app_text.dart';
import 'package:gau_app/utils/color/app_colors.dart';
import 'package:gau_app/utils/extension/base_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back_ios)),
        
        title: Text(AppText.transcript,
        style:   GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600
          ),
        ),
        
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [

            CustomContainer(
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  Text(AppText.academicTranscript,style: context.titleMedium,),
                  SizedBox(height: 4.h,),
                  Text(AppText.officialRecord,style: context.bodySmall,),
                    SizedBox(height: 24.h,),
                    OutlinedButton(onPressed: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppText.print),
                        SizedBox(width: 12.w,),
                        CustomImage(imageSrc: AppAssets.print),
                    ],)),
                    SizedBox(height:  16.h,),
                    ElevatedButton(onPressed: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImage(imageSrc: AppAssets.download),

                        SizedBox(width: 12.w,),
                        Text(AppText.downloadPdf),
                      ],))

            ],)),

            SizedBox(height: 24.h,),
            CustomImage(imageSrc: AppAssets.pdf)

          ],
        ),
      ),

    );
  }
}
