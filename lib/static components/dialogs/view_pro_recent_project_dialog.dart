// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/features/home/widget/project_img_card_widget.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../provider/notifiers/estimate_notifier.dart';
import '../../res/common/my_text.dart';
import '../../utils/constants/app_colors.dart';

class ProRecentProjectDialog extends StatelessWidget {
  final int index;
  const ProRecentProjectDialog({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final notifier = context.watch<EstimateNotifier>();
    final proRecentProject =
        notifier.proDetails.prodata!.proRecentProjects![index];

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: height / 1.85,
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
                MyTextPoppines(
                  text: proRecentProject.projectName.toString(),
                  fontSize: context.screenHeight / 50,
                  fontWeight: FontWeight.w600,
                  height: 1.8,
                  textAlign: TextAlign.center,
                  color: AppColors.black,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyTextPoppines(
                          text: "  Customer Ratings",
                          fontSize: context.screenHeight / 60,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: const Color(0xFFF3F9FF),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: Colors.amber.shade600,
                                size: 30.sp,
                              ),
                              6.hs,
                              MyTextPoppines(
                                text: proRecentProject.avgRating.toString(),
                                fontSize: context.screenHeight / 65,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlue,
                              ),
                              10.hs,
                              Container(
                                width: 2.w,
                                height: 34.h,
                                color: AppColors.black.withOpacity(0.3),
                              ),
                              10.hs,
                              MyTextPoppines(
                                text: "3.5 out of 5",
                                fontSize: context.screenHeight / 65,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        10.hs,
                      ],
                    ),
                    const Divider(thickness: 1.0),
                    5.vs,
                    MyTextPoppines(
                      text: "What our user say about this service.",
                      fontSize: context.screenHeight / 65,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.9),
                    ),
                    5.vs,
                    MyTextPoppines(
                      text: proRecentProject.review.toString(),
                      fontSize: context.screenHeight / 75,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.6),
                      maxLines: 3,
                    ),
                    _buildImgCard(
                      context: context,
                      containerBgColor: Color(0xFFEDF5FD),
                      img: proRecentProject.beforeWorkImages!,
                    ),
                    _buildImgCard(
                      context: context,
                      containerBgColor: Color(0xFFFEF8ED),
                      isBeforWorkCard: false,
                      img: proRecentProject.afterWorkImages!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImgCard({
    required BuildContext context,
    required Color containerBgColor,
    bool isBeforWorkCard = true,
    required List<String> img,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isBeforWorkCard ? Color(0xFFEDF5FD) : Color(0xFFFEF8ED),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextPoppines(
            text: isBeforWorkCard ? "Before Work :" : "After Work :",
            fontSize: context.screenHeight / 80,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          Divider(thickness: 1.0),
          SizedBox(
            height: height / 10,
            child: ListView.builder(
              itemCount: img.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: width / 28),
                  child: ProjectImgCardWidget(
                    width: width / 4.5,
                    height: height / 20,
                    imgPath: img[index],
                    isNetworkImg: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
