// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/resources/common/my_app_bar.dart';
import 'package:new_user_side/resources/common/buttons/my_buttons.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/features/home/widget/project_img_card_widget.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/sizer.dart';

class EWOCompletedProjectsScreenCardWidget extends StatelessWidget {
  final bool? isEstimatedWork;
  final bool? isOngoingProject;
  final VoidCallback onTap;
  const EWOCompletedProjectsScreenCardWidget({
    Key? key,
    this.isEstimatedWork = true,
    this.isOngoingProject = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    double getChildAspectRatio() {
      if (isEstimatedWork!) {
        return height > 800
            ? 1 / 1.3
            : height > 700
                ? 1 / 1.25
                : height > 600
                    ? 1 / 1.14
                    : 1 / 1.12;
      } else if (isOngoingProject!) {
        return height > 800
            ? 1 / 1.34
            : height > 700
                ? 1 / 1.30
                : height > 600
                    ? 1 / 1.22
                    : 1 / 1.16;
      } else {
        return height > 800
            ? 1 / 1.43
            : height > 700
                ? 1 / 1.4
                : height > 600
                    ? 1 / 1.30
                    : 1 / 1.24;
      }
    }

    final sliverGrid = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: getChildAspectRatio(),
      mainAxisSpacing: 15.h,
    );

    return Scaffold(
      appBar: MyAppBar(
        text: isEstimatedWork!
            ? "Estimated Work"
            : isOngoingProject!
                ? "Ongoing Project"
                : "Project History",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            10.vs,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: MyTextPoppines(
                text: isEstimatedWork!
                    ? "Here’s the list of all your estimated work."
                    : isOngoingProject!
                        ? "Here’s the list of all ongoing projects."
                        : "We have record of your last projects .Tap to view details.",
                fontSize: height / MyFontSize.font16,
                fontWeight: FontWeight.w500,
              ),
            ),
            20.vs,
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: sliverGrid,
                itemBuilder: (context, index) {
                  return EWOPHGridCard(
                    isEstimatedWork: isEstimatedWork,
                    isOngoingProject: isOngoingProject,
                    onTap: onTap,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EWOPHGridCard extends StatelessWidget {
  const EWOPHGridCard({
    Key? key,
    required this.isEstimatedWork,
    required this.isOngoingProject,
    required this.onTap,
  }) : super(key: key);

  final bool? isEstimatedWork;
  final bool? isOngoingProject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Radius cr12 = Radius.circular(12.r);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(20, 0, 0, 0),
            blurRadius: 10.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading of card
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 12.h),
            child: MyTextPoppines(
              text: "Bathroom Renewal",
              fontWeight: FontWeight.w500,
              fontSize: height > 800 ? 10.sp : 12.sp,
            ),
          ),
          const Divider(thickness: 1.2),
          // Bookibg id
          Container(
            height: 22.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.yellow.withOpacity(0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyTextPoppines(
                  text: "Booking ID :",
                  fontSize: height > 800 ? 8.sp : 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                MyTextPoppines(
                  text: "OD-058699S",
                  fontSize: height > 800 ? 8.sp : 10.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.yellow,
                ),
              ],
            ),
          ),
          const Divider(thickness: 1.0),
          isEstimatedWork!
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyTextPoppines(
                            text: "Project Cost :",
                            fontWeight: FontWeight.w400,
                            fontSize: height > 800 ? 7.sp : 9.sp,
                          ),
                          10.hs,
                          MyTextPoppines(
                            text: "\$1200",
                            fontWeight: FontWeight.w600,
                            fontSize: height > 800 ? 7.sp : 9.sp,
                          ),
                        ],
                      ),
                      5.vs,
                      Row(
                        children: [
                          MyTextPoppines(
                            text: "Project Started :",
                            fontWeight: FontWeight.w400,
                            fontSize: height > 800 ? 7.sp : 9.sp,
                          ),
                          10.hs,
                          MyTextPoppines(
                            text: "10/02/2023",
                            fontWeight: FontWeight.w500,
                            fontSize: height > 800 ? 6.sp : 8.sp,
                          ),
                          10.hs,
                        ],
                      ),
                      isOngoingProject! ? 0.vs : 5.vs,
                      isOngoingProject!
                          ? const SizedBox()
                          : Row(
                              children: [
                                MyTextPoppines(
                                  text: "Project Completed :",
                                  fontWeight: FontWeight.w400,
                                  fontSize: height > 800 ? 7.sp : 9.sp,
                                ),
                                10.hs,
                                MyTextPoppines(
                                  text: "10/03/2023",
                                  fontWeight: FontWeight.w500,
                                  fontSize: height > 800 ? 6.sp : 8.sp,
                                ),
                                10.hs,
                              ],
                            ),
                    ],
                  ),
                ),
          // Project Details container
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: cr12, bottomRight: cr12),
              color: AppColors.yellow,
              image: const DecorationImage(
                image: AssetImage("assets/images/room/2(1).png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextPoppines(
                  text: "  Project Photos:",
                  color: AppColors.white,
                  fontSize: 12.sp,
                ),
                10.vs,
                // Project Images
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProjectImgCardWidget(
                      width: 44.w,
                      height: 40.h,
                      borderWidth: 0.5.w,
                      imgPath: "assets/images/room/2(1).png",
                    ),
                    ProjectImgCardWidget(
                      width: 44.w,
                      height: 40.h,
                      borderWidth: 0.5.w,
                      imgPath: "assets/images/room/room_3.png",
                    ),
                    Stack(
                      children: [
                        ProjectImgCardWidget(
                          width: 44.w,
                          height: 40.h,
                          borderWidth: 0.5.w,
                          imgPath: "assets/images/room/room_1.png",
                        ),
                        Positioned(
                          left: 10.w,
                          top: 10.h,
                          child: MyTextPoppines(
                            text: " +5\nMore",
                            fontSize: height / MyFontSize.font8,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                isEstimatedWork! ? 15.vs : 8.vs,
                // Project Estimated Cost
                isEstimatedWork!
                    ? MyTextPoppines(
                        text: "Estimated Amount: \$1200",
                        fontSize: 10.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      )
                    : const SizedBox(),
                Divider(
                  thickness: 1.0,
                  color: AppColors.white.withOpacity(0.5),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyBlueButton(
                    hPadding: 14.w,
                    vPadding: height < 600 ? 16.h : 7.h,
                    fontSize: 10.sp,
                    text: "View Details",
                    fontWeight: FontWeight.w500,
                    onTap: onTap,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
