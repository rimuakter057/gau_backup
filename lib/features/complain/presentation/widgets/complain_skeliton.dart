import 'package:flutter/material.dart';
import 'package:gau_app/features/common/widgets/custom_shimmer.dart';
import 'package:gau_app/helper/responsive_helper/responsive_helper.dart';


class ComplainScreenSkeleton extends StatelessWidget {
  const ComplainScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: ResponsiveHelper.height(16)),

          /// ── HEADER CARD ─────────────────────────────
       //   _HeaderSkeleton(),

          SizedBox(height: ResponsiveHelper.height(20)),

          /// ── LIST SKELETON ───────────────────────────
          ListView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => const _ComplaintCardSkeleton(),
          ),
        ],
      ),
    );
  }
}

class _ComplaintCardSkeleton extends StatelessWidget {
  const _ComplaintCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:  ResponsiveHelper.height(10),),
      child: CustomShimmer(
        child:          Container(
          height: ResponsiveHelper.height(80),
          width: double.infinity,
     
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(10))
          ),
        ),
      ),
    );
  }
}