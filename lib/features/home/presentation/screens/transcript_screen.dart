
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';
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
              fontSize: ResponsiveHelper.fontSize(14),
              color: AppColors.titleColor,
              fontWeight: FontWeight.w600
          ),
        ),
        
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:  ResponsiveHelper.padding(16)),
        child: Column(
          children: [

            CustomContainer(
                backgroundColor: AppColors.containerGreyBgColor,
                borderColor: AppColors.inputBorderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  Text(AppText.academicTranscript,style: context.titleMedium,),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Text(AppText.officialRecord,style: context.bodySmall,),
                    SizedBox(height:  ResponsiveHelper.height(24)),
                    OutlinedButton(onPressed: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppText.print),
                        SizedBox(width:  ResponsiveHelper.width(12)),
                        CustomImage(imageSrc: AppAssets.print),
                    ],)),
                    SizedBox(height:   ResponsiveHelper.height(16)),
                    ElevatedButton(onPressed: (){}, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImage(imageSrc: AppAssets.download),

                        SizedBox(width: ResponsiveHelper.width(12)),
                        Text(AppText.downloadPdf),
                      ],))

            ],)),

            SizedBox(height:  ResponsiveHelper.height(24)),
            CustomImage(imageSrc: AppAssets.pdf)

          ],
        ),
      ),

    );
  }
}
