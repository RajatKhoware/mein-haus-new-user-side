import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/pro%20profile/view/widget/pro_rating_card.dart';
import 'package:new_user_side/features/pro%20profile/view/widget/pro_recent_project_card.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../../../provider/notifiers/estimate_notifier.dart';

class ProProfileWidget extends StatelessWidget {
  const ProProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final pro = notifier.proDetails.prodata;

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pro -> Profile/Name/Company Name/Moto
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const AssetImage("assets/images/man.png"),
              ),
              20.hs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextPoppines(
                    text: pro?.proName ?? "",
                    fontSize: context.screenHeight / MyFontSize.font12,
                    fontWeight: FontWeight.bold,
                  ),
                  5.vs,
                  MyTextPoppines(
                    text: pro?.proCompanyName ?? "",
                    fontSize: width / 42,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  5.vs,
                  SizedBox(
                    width: context.screenWidth / 1.5,
                    child: MyTextPoppines(
                      text: pro?.proMotive ?? "",
                      fontSize: width / 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                      maxLines: 5,
                    ),
                  ),
                ],
              )
            ],
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          // Verfied Pro + No. Of Jobs completed
          Row(
            children: [
              Container(
                width: width / 3.1,
                decoration: BoxDecoration(
                  color: Color(0xFF13F200).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width / 32,
                  vertical: height / 80,
                ),
                child: Row(
                  children: [
                    Image.asset("assets/icons/approved.png"),
                    MyTextPoppines(
                      text: "Verfied Pro",
                      height: 1.8,
                      fontSize: context.screenHeight / MyFontSize.font12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              30.hs,
              Container(
                width: context.screenWidth / 2.93,
                decoration: BoxDecoration(
                  color: Color(0xFFE8F4FF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Row(
                  children: [
                    MyTextPoppines(
                      text: pro?.jobsDone.toString() ?? "",
                      height: 1.8,
                      fontSize: context.screenHeight / MyFontSize.font12,
                      fontWeight: FontWeight.bold,
                    ),
                    5.hs,
                    MyTextPoppines(
                      text: "Job Completed",
                      height: 1.8,
                      fontSize: context.screenHeight / MyFontSize.font12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          MyTextPoppines(
            text: "Services Offered :",
            fontSize: context.screenHeight / MyFontSize.font14,
            fontWeight: FontWeight.w500,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 10.h),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pro?.serviceOffered!.length,
              itemBuilder: (context, index) {
                final String? service = pro?.serviceOffered![index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: MyTextPoppines(
                    text: "•   $service",
                    fontSize: context.screenHeight / MyFontSize.font10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                );
              },
            ),
          ),
          5.vs,
          Divider(thickness: 0.8),
          10.vs,
          MeinHouseProRatingCard(),
          20.vs,
          ProRecentProjectsCardWidget()
        ],
      ),
    );
  }
}
