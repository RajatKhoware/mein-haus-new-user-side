// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../provider/notifiers/estimate_notifier.dart';
import '../../resources/common/my_text.dart';
import '../../utils/constants/app_colors.dart';

class ProWorkDetailsDialog extends StatelessWidget {
  const ProWorkDetailsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final notifier = context.watch<EstimateNotifier>();
    final workDetails = notifier
        .projectDetails.services!.professionalWorkHistory![0].workDetails;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: height / 3.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: MyTextPoppines(
                    text: "Professional Work Details",
                    fontSize: context.screenHeight / 50,
                    fontWeight: FontWeight.w600,
                    height: 1.8,
                    color: AppColors.black,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 12.r,
                    backgroundColor: AppColors.textBlue.withOpacity(0.15),
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 12.sp,
                      color: AppColors.black,
                    ),
                  ),
                )
              ],
            ),
            const Divider(thickness: 1.0),
            3.vspacing(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyTextPoppines(
                  text: "S.No.",
                  fontSize: context.screenHeight / 70,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                MyTextPoppines(
                  text: "Start Time",
                  fontSize: context.screenHeight / 70,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                MyTextPoppines(
                  text: "End Time",
                  fontSize: context.screenHeight / 70,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                MyTextPoppines(
                  text: "Time In Minute",
                  fontSize: context.screenHeight / 70,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ],
            ),
            3.vspacing(context),
            const Divider(thickness: 1.0),
            3.vspacing(context),
            ListView.builder(
              shrinkWrap: true,
              itemCount: workDetails!.length,
              itemBuilder: (context, index) {
                final details = workDetails[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyTextPoppines(
                      text: "${index + 1}",
                      fontSize: context.screenHeight / 70,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.7),
                    ),
                    SizedBox(
                      width: context.screenWidth / 6,
                      child: MyTextPoppines(
                        text: details.startTime.toString(),
                        fontSize: context.screenHeight / 70,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth / 6,
                      child: MyTextPoppines(
                        text: details.endTime.toString(),
                        fontSize: context.screenHeight / 70,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth / 10,
                      child: MyTextPoppines(
                        text: details.totalTimeInMinutes.toString(),
                        fontSize: context.screenHeight / 70,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
            3.vspacing(context),
            const Divider(thickness: 1.0),
            3.vspacing(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextPoppines(
                  text: "Total TIme :",
                  fontSize: context.screenHeight / 60,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                5.hspacing(context),
                MyTextPoppines(
                  text: "122 Minutes",
                  fontSize: context.screenHeight / 60,
                  fontWeight: FontWeight.w600,
                  color: AppColors.yellow,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
