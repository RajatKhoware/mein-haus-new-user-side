import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../../../provider/notifiers/estimate_notifier.dart';

class MeinHouseProRatingCard extends StatelessWidget {
  const MeinHouseProRatingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EstimateNotifier>();
    final pro = notifier.proDetails.prodata!;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.vs,
          MyTextPoppines(
            text: "Pro Rating",
            fontSize: context.screenHeight / MyFontSize.font14,
            fontWeight: FontWeight.w600,
          ),
          Divider(thickness: 0.8),
          5.vs,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFFF3F9FF),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber.shade600,
                      size: 40.sp,
                    ),
                    6.hs,
                    MyTextPoppines(
                      text: "${pro.proRating!.avgRating}/5",
                      fontSize: context.screenHeight / MyFontSize.font14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlue,
                    ),
                    10.hs,
                    Container(
                      width: 2.w,
                      height: 40.h,
                      color: AppColors.black.withOpacity(0.3),
                    ),
                    10.hs,
                    MyTextPoppines(
                      text: "${pro.proRating!.avgRating} out of 5",
                      fontSize: context.screenHeight / MyFontSize.font13,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              10.hs,
              MyTextPoppines(
                text: "${pro.proRating!.totalRating} Customer ratings",
                fontSize: context.screenHeight / MyFontSize.font10,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(0.6),
              ),
            ],
          ),
          10.vs,
          Divider(thickness: 0.8),
          RatingCardStatusContant(
            size: size,
            title: "Responsive",
            // valueNo: "(22)",
            valueProgress: pro.proRating!.responsiveness! * 0.01,
          ),
          RatingCardStatusContant(
            size: size,
            title: "Punctuality",
            //  valueNo: "(10)",
            valueProgress: pro.proRating!.punctuality! * 0.01,
          ),
          RatingCardStatusContant(
            size: size,
            title: "Quality",
            //    valueNo: "(54)",
            valueProgress: pro.proRating!.responsiveness! * 0.01,
          )
        ],
      ),
    );
  }
}

class RatingCardStatusContant extends StatelessWidget {
  const RatingCardStatusContant({
    super.key,
    required this.size,
    required this.title,
    //  required this.valueNo,
    required this.valueProgress,
  });

  final Size size;
  final String title;
  final double valueProgress;
  // final String valueNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.24,
            child: MyTextPoppines(
              text: title,
              fontSize: size.height * 0.015,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: size.width * 0.4,
            height: size.height * 0.016,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: valueProgress,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xffFFBC48),
                ),
                backgroundColor: const Color(0xffECF3F7),
              ),
            ),
          ),
          // MyTextPoppines(
          //   text: valueNo,
          //   fontSize: size.height * 0.015,
          //   fontWeight: FontWeight.w400,
          // ),
        ],
      ),
    );
  }
}
