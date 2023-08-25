// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/provider/notifiers/estimate_notifier.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/constants/constant.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../screens/estimate_work_deatils_screen.dart';

class AllEstimateWorkCard extends StatelessWidget {
  final int index;
  const AllEstimateWorkCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final notifier = context.read<EstimateNotifier>();
    final estimate = notifier.estimated.estimatedWorks![index];
    final estimateCost = estimate.projectBilling!.projectAmount.toString();
    final isImgNull = estimate.uploadedImgs!.length == 0;
    final headline1 = width / 35;

    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 25, vertical: height / 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width / 20, vertical: height / 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xFFEDF6FF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextPoppines(
                  text: estimate.projectName.toString(),
                  fontSize: width / 28,
                  fontWeight: FontWeight.w600,
                ),
                // Project Cost
                Container(
                  width: width / 3.6,
                  margin: EdgeInsets.only(right: width / 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.golden),
                    color: Color(0xFFFFFCF6),
                  ),
                  child: Column(
                    children: [
                      1.vspacing(context),
                      MyTextPoppines(
                        text: "Project Cost",
                        fontSize: headline1,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Divider(
                        thickness: 1,
                        height: 10,
                        color: AppColors.golden.withOpacity(0.6),
                      ),
                      MyTextPoppines(
                        text: "\$${estimateCost}",
                        fontSize: headline1,
                        fontWeight: FontWeight.bold,
                        color: AppColors.golden,
                      ),
                      1.vspacing(context),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(thickness: 1.0, height: 5.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.vspacing(context),
                // Booking Id
                Row(
                  children: [
                    MyTextPoppines(
                      text: "Booking ID :  ",
                      fontSize: headline1,
                      fontWeight: FontWeight.w500,
                    ),
                    MyTextPoppines(
                      text: estimate.estimateId.toString(),
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.4),
                    ),
                  ],
                ),
                5.vspacing(context),
                // Photos
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextPoppines(
                      text: "Photos :",
                      fontSize: headline1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                    isImgNull
                        ? MyTextPoppines(
                            text: "     No Img uploaded yet",
                            fontSize: headline1,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonBlue.withOpacity(0.8),
                          )
                        : SizedBox(
                            height: height / 13,
                            width: width / 1.4,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: estimate.uploadedImgs!.length,
                              itemBuilder: (context, index) {
                                final images = estimate.uploadedImgs![index];
                                return Container(
                                  margin: EdgeInsets.only(left: width / 30),
                                  padding: EdgeInsets.all(4),
                                  width: width / 5.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.golden,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(images.thumbnailUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ),
                2.vspacing(context),
                Divider(thickness: 1.0),
                2.vspacing(context),
                // View details button
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EstimatedWorkDetailScreen.routeName,
                          arguments: index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 1.5.w,
                          color: AppColors.textBlue1E9BD0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width / 28,
                        vertical: height / 100,
                      ),
                      child: MyTextPoppines(
                        text: "View Details",
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonBlue,
                        fontSize: headline1,
                      ),
                    ),
                  ),
                ),
                4.vspacing(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}
