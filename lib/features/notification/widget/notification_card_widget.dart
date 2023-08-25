import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

class NotificationCardWidget extends StatelessWidget {
  final String iconImgUrl;
  final String notifiHeading;
  final String notifiSubHeading;
  final String notifiTime;
  final bool? isFreshNotifi;
  const NotificationCardWidget({
    Key? key,
    required this.iconImgUrl,
    required this.notifiHeading,
    required this.notifiSubHeading,
    required this.notifiTime,
    this.isFreshNotifi = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: isFreshNotifi!
          ? AppColors.yellow.withOpacity(0.15)
          : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.yellow.withOpacity(0.8),
                ),
                child: Image.asset(
                  iconImgUrl,
                  fit: BoxFit.fill,
                ),
              ),
              10.hs,
              SizedBox(
                width: height > 800 ? 250.sp : 260.w,
                height: 40.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextPoppines(
                      text: notifiHeading,
                      fontSize: height > 800 ? 9.sp : 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.8),
                      maxLines: 2,
                    ),
                    // 12.vs,
                    MyTextPoppines(
                      text: notifiSubHeading,
                      fontSize: height > 800 ? 9.sp : 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.4),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          MyTextPoppines(
            text: notifiTime,
            fontSize: height > 800 ? 8.sp : 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.yellow,
          ),
        ],
      ),
    );
  }
}
