// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../provider/notifiers/estimate_notifier.dart';

class ProjectBillingCardWidget extends StatelessWidget {
  final int index;
  const ProjectBillingCardWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight;
    final notifier = context.watch<EstimateNotifier>().estimated;
    final pBill = notifier.estimatedWorks![index].projectBilling!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1.0,
          color: AppColors.yellow,
        ),
        color: const Color(0xFFFEF8EE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          8.vspacing(context),
          _buildShowPrice(
            context: context,
            text: "Subtotal : \$${pBill.subTotal}",
            fontWeight: FontWeight.w600,
          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
            text: "HST 13% (830275681RRT0001) = \$${pBill.hstForSubtotal}",
          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
            text: "Total : \$${pBill.total}",
            fontWeight: FontWeight.w600,
          ),
          2.vspacing(context),
          Divider(
            thickness: 1.2,
            color: AppColors.yellow.withOpacity(0.35),
          ),
          2.vspacing(context),
          _buildShowPrice(
            context: context,
            text: "Deposit for project Booking = \$${pBill.depositAmount}",
          ),
          4.vspacing(context),
          _buildShowPrice(
            context: context,
            text: "HST 13% (830275681RRT0001) = \$${pBill.hstForDepositAmount}",
          ),
          5.vspacing(context),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
              ),
              color: AppColors.black,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MyTextPoppines(
                text: "Total : \$${pBill.totalDepositAmount}",
                fontSize: height / 60,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShowPrice({
    required BuildContext context,
    required String text,
    FontWeight? fontWeight = FontWeight.w500,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: MyTextPoppines(
        text: text,
        fontSize: context.screenHeight / 60,
        fontWeight: fontWeight,
      ),
    );
  }
}


//  Padding(
//             padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
//             child: MyTextPoppines(
//               text: "HST 13% (830275681RRT0001) = \$49.27",
//               fontSize: height > 800
//                   ? height / MyFontSize.font12
//                   : height / MyFontSize.font14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),