// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../../resources/common/my_text.dart';

class CheckOutSummaryCardWidget extends StatelessWidget {
  final String totalAmount;
  const CheckOutSummaryCardWidget({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextPoppines(
          text: "Summary",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        15.vs,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(20, 0, 0, 0),
                offset: const Offset(0, 0),
                blurRadius: 10.r,
                spreadRadius: 2.r,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextPoppines(
                text: "Project details",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              20.vs,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextPoppines(
                          text: "Bathroom Renewal",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        MyTextPoppines(
                          text:"\$${totalAmount}",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    15.vs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextPoppines(
                          text: "Other charges",
                          fontSize: 14.sp,
                        ),
                        MyTextPoppines(
                          text: "0",
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                    15.vs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyTextPoppines(
                          text: "Discount & Offer",
                          fontSize: 14.sp,
                        ),
                        MyTextPoppines(
                          text: "0",
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.2),
              10.vs,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextPoppines(
                    text: "To Pay",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  MyTextPoppines(
                    text: "\$${totalAmount}",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
